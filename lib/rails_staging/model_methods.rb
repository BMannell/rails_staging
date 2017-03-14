module RailsStaging
  module ModelMethods
    extend ActiveSupport::Concern

    @@stageable_columns = []

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
      if stage = rails_stages.find_by!(uuid: uuid)
        stage.apply
      end
    end

    def apply_all(column = nil)
      stages = rails_stages.where(applied: false)
      if column.present?
        stages = stages.where(column: column)
      end
      ActiveRecord::Base.transaction do
        stages.each do |stage|
          stage.apply
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
      puts "stage #{column} #{value}"
      rails_stages.create(column: column, predecessor: current_version(column), value: value.to_s, type: value.class.name)
    end

    def current_version(column)
      if stage = rails_stages.where(column: column, applied: true).last
        stage.uuid
      else
        ""
      end
    end



    private

    def create_rails_stages
      @staged_changes = changes
      @@stageable_columns.each do |column|
        if changed.include?(column)
          new_value = read_attribute(column)
          old_value = eval("#{column}_was")
          write_attribute(column, old_value)
          self.rails_stages.build(column: column, predecessor: old_value, value: new_value, type: self.class.columns_hash[column].type.to_s )
        end
      end
    end

    public

    module ClassMethods

      def stage(*columns)
        validate :create_rails_stages
        has_many :rails_stages, as: :stageable unless instance_methods.include?(:rails_stages)
        columns.each{|col| add_stageable_column(col.to_s)}
      end

      def add_stageable_column(column)
        arr = class_variable_get(:@@stageable_columns)
        arr << column
        class_variable_set(:@@stageable_columns, arr)
      end

    end
  end
end
