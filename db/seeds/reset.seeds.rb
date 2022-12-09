# frozen_string_literal: true

ActiveRecord::Base.connection.tables.each do |table|
  unless %w[ar_internal_metadata schema_migrations].include?(table)
    ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
    ActiveRecord::Base.connection.execute("UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME='#{table}'")
  end
end
