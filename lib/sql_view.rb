class SqlView
  class << self
    def view_name(name = nil)
      @view_name = name if name
      @view_name
    end

    def sql(sql = nil)
      @sql = sql if sql
      @sql
    end

    def create
      ActiveRecord::Base.connection.execute <<-SQL
        create or replace view #{view_name} as
        #{sql}
      SQL
    end

    def drop
      ActiveRecord::Base.connection.execute "drop view #{view_name}"
    end
  end
end