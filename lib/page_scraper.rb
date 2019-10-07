class PageScraper
  MAX_REDIRECTS = 5

  attr_accessor :url_str

  def initialize(url_str)
    self.url_str = url_str
  end

  def extract_tag(tag_name)
    ensure_page_is_loaded

    regexp = /<#{tag_name}>(.*?)<\/#{tag_name}>/

    if matches = @page.match(regexp)
      matches[1]
    end
  end

  private

  def load_page(url_str, max_redirects)
    raise ArgumentError, "HTTP redirect exceeds maximum of #{MAX_REDIRECTS}" if max_redirects == 0

    response = Net::HTTP.get_response(URI.parse(url_str))

    if response.code == "301"
      response = load_page(response.header['location'], max_redirects - 1)
    else
      @page = response.body
    end
  end

  def ensure_page_is_loaded
    if (@page.nil?)
      load_page(self.url_str, MAX_REDIRECTS)
    end
  end

end
