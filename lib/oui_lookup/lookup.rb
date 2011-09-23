# Look up an IEEE Organizationally Unique Identifier (OUI).
module OUI_Lookup
  class Lookup
    require 'rest-client'
    require 'nokogiri'

    URL = 'http://standards.ieee.org/cgi-bin/ouisearch'
    attr :oui, :silent_searching

    # Create an OUI_Lookup search object, given a MAC address or vendor
    # prefix.
    def initialize oui, silent_searching=false
      @oui = oui.to_s.scan /\h{2}/
      validate!

      # The oui.txt file lists three-octet OUI prefixes in both
      # dash-separated and conjoined formats. The OUI with dashes seems
      # less likely to be confused with other data on the page (say, ZIP
      # codes) and makes a more reliable search term.
      @oui = @oui.take(3).join '-'
      @silent_searching = silent_searching
    end

    # Returns the results of a successful lookup, or a "not found" error.
    def run
      result = vendor(parse lookup)
      if result
        puts result unless @silent_searching
      else
        warn "OUI not found: " << @oui unless result
      end
      return result
    end

    # Returns the raw HTML document from a POST search.
    def lookup
     printf "Searching...\n\n" unless @silent_searching
     html = RestClient.post URL, { x: @oui }
     error_page?(html) ? raise( RuntimeError, html ) : html
    end

    # Check for error pages that improperly return a 2xx status code.
    # 
    # [Sorry]
    #   Apparently included on all error pages with a 200 status code.
    # [Searching for nothing]
    #   POST an invalid or empty search term (e.g. x is an array).
    # [no match for the query]
    #   No match found. Not actually an error, per se. Handled in #run.
    def error_page? html
      return true if html.include? 'Searching for nothing'
    end

    # Return a Nokogiri nodelist.
    def parse html
      node_list = Nokogiri::HTML.parse html
    end

    # Return text node containing vendor data.
    def vendor node_list
      node = node_list.at_xpath('//pre')
      node ? node.text : nil
    end

    private
    # Returns true if @oui looks like a MAC address or vendor prefix.
    def validate!
      raise ArgumentError, "invalid MAC length: #{@oui.size}" \
      unless @oui.size == 3 || @oui.size == 6
    end
  end # class Lookup
end # module OUI_Lookup
