module RailsStaging
  module ModelMethods
    extend ActiveSupport::Concern

    def revert

    end

    def revert_to

    end

    def history

    end

    def apply(columns = {}, number = -1)
      stage = RailsStage.where({table: self.class.table_name, column: columns}).first
      self.send("set_#{columns}", stage.to)
    end

    def stage(args)
      RailsStage.create({table: self.class.table_name, column: args[:column], from: args[:from], to: args[:to]})
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

            self.stage(column: column, from: self[column], to: value)
          end
        end
      end
    end
  end
end
