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
      if column.present?
        rails_stages.where(column: column)
      else
        rails_stages
      end
    end

    def apply(uuid)
      stage = rails_stages.find_by!(uuid: uuid)
      self.send("set_#{stage.column}", stage.value)
      stage.update({applied: true})
    end

    def apply_all(column = nil)

      stages = rails_stages.where(applied: false)

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
      rails_stages.create(column: column, predecessor: current_version(column), value: value, type: value.class.name)
    end

    def current_version(column)
      if stage = rails_stages.where(column: column, applied: true).last
        stage.uuid
      else
        ""
      end
    end

    module ClassMethods

      def stage(*columns)

        puts instance_methods.sort.join("\n")

        ##
        # TODO
        #  - overwrite setter
        #  - attach associations

        columns.each do |column|

          old_setter = instance_method("#{column}=")

          define_method "set_#{column}" do |value|
            old_setter.bind(self).(value)
          end

          define_method "#{column}=" do |value|
            puts "setting"
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
