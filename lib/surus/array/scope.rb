module Surus
  module Array
    module Scope
      # Adds where condition that requires column to contain all values
      #
      # Examples:
      #   User.array_has(:permissions, "manage_users")
      #   User.array_has(:permissions, "manage_users", "manage_roles")
      #   User.array_has(:permissions, ["manage_users", "manage_roles"])
      def array_has(column, *values)
        where("#{connection.quote_column_name(column)} @> ARRAY[?]", values.flatten)
      end
      
      # Adds where condition that requires column to contain any values
      #
      # Examples:
      #   User.array_has_any(:permissions, "manage_users")
      #   User.array_has_any(:permissions, "manage_users", "manage_roles")
      #   User.array_has_any(:permissions, ["manage_users", "manage_roles"])
      def array_has_any(column, *values)
        where("#{connection.quote_column_name(column)} && ARRAY[?]", values.flatten)    
      end
    end
  end
end

ActiveRecord::Base.extend Surus::Array::Scope
