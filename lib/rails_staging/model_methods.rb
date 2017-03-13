module RailsStaging
  module ModelMethods
    extend ActiveSupport::Concern

    def revert_to(var)
      stages = if var.is_a? Date
        history.where("created_at <= ?", [var])
      elsif var.is_a? String
        history.where(uuid: var)
      else
        raise ArgumentError, "Argument is not a Date or String"
      end

      stages.order(id: :desc)

      ActiveRecord::Base.transaction do
        stages.each do |stage|
          self.send("set_#{stage.column}", stage.value)
          stage.update({applied: false})
        end
      end

    end

    def history(column=nil)
      stages = RailsStage.where(table: self.class.table_name, row_id: self.id)
      if column.present?
        stages.where(column: column)
      end
      stages
    end

    def apply(uuid)
      stage = RailsStage.find_by!(uuid: uuid)
      self.send("set_#{stage.column}", stage.value)
      stage.update({applied: true})
    end

    def apply_all(column = nil)

      stages = RailsStage.where(table: self.class.table_name, row_id: self.id, applied: false)

      if column.present?
        stages.where(column: column)
      end

      ActiveRecord::Base.transaction do
        stages.each do |stage|
          self.send("set_#{stage.column}", stage.value)
          stage.update({applied: false})
        end
      end
    end

    ##
    # Function to stage a new change to the record
    #
    # Parameters:
    #
    # - :column - the column that is beign updated
    # - :value
    def stage(column, value)

      # TODO
      # - check if record has been saved, save if not
      self.save
      RailsStage.create(table: self.class.table_name, column: column, row_id: self.id, predecessor: current_version(column), text_value: value, type: value.class.name)
    end

    def current_version(column)
      if stage = RailsStage.where(table: self.class.table_name, column: column, row_id: self.id, applied: true).last
        stage.uuid
      else
        ""
      end
    end

    module ClassMethods

      def stage(*columns)

        ##
        # TODO
        #  - overwrite setter
        #  - attach associations
        #
        columns.each do |column|
          attr_accessor column

          old_setter = instance_method("#{column}=")

          define_method "set_#{column}" do |value|
            old_setter.bind(self).(value)
          end

          define_method "#{column}=" do |value|

            ##
            # TODO
            # - add check for condition

            self.stage(column,value)
          end
        end
      end
    end
  end
end
