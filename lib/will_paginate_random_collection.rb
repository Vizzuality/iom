module WillPaginate
  class RandomCollection < Collection
    attr_reader :current_page, :per_page, :total_entries, :total_pages, :start_in_page

    def initialize(page, per_page, total, start_in_page)
      @start_in_page = start_in_page
      @current_page = page.to_i
      raise InvalidPage.new(page, @current_page) if @current_page < 1
      @per_page = per_page.to_i
      raise ArgumentError, "`per_page` setting cannot be less than 1 (#{@per_page} given)" if @per_page < 1

      self.total_entries = total if total
    end

    def self.create(page, per_page, total, start_in_page, &block)
      pager = new(page, per_page, total, start_in_page)
      yield pager
      pager
    end

  end
end
