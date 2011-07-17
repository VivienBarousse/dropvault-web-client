require 'net/dav'

module DropDAV

  class DropDAV < Net::DAV

    def item(path)
      pathUri = @uri.merge(path)
      headers = {'Depth' => '0'}
      body = '<?xml version="1.0" encoding="utf-8"?><DAV:propfind xmlns:DAV="DAV:"><DAV:allprop/></DAV:propfind>'
      res = @handler.request(:propfind, pathUri.path, body, headers.merge(@headers))
      xml = Nokogiri::XML.parse(res.body)
      namespaces = {'x' => 'DAV:'}
      response = xml./('.//x:response', namespaces)
      uri = @uri.merge(response.xpath("x:href", namespaces).inner_text)
      size = response.%(".//x:getcontentlength", namespaces).inner_text rescue nil
      type = response.%(".//x:collection", namespaces) ? :directory : :file
      Item.new(self, uri, type, size, response) 
    end

  end

end
