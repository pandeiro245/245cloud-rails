class Ruffnote
  BASE = "/api/v1"
  
  # site
  ID = 'd0774a954f08bf2c7fe2dad64891129ae80187922c29bec1f01eaca3d54b79a7'
  SECRET = '08727041a70fd986ec3fd3daa32d610412c93f7d7867d83304a8f9a1c8cc7939'
  SITE = 'https://ruffnote.com'
  
  # user (pandeiro245)
  CODE = "0cef346952f3ff665b5e13782a4de13ae15245a9f5048b053d1f4415adfaec8e"
  STATE = "8f982a5918df277e2a29dd5301b90dae268ed0aaa81ac6f3"

  def initialize
    token = CODE
    client = OAuth2::Client.new(
      ID,
      SECRET,
      site: SITE
    )
    @ruffnote = OAuth2::AccessToken.new(client, token)
  end  
  
  def get_pages
    team = 'pandeiro245'
    note = '245cloud'
    url = "#{BASE}/#{team}/#{note}/pages.json"
    
    # @ruffnote.get(url).parsed
    
    @ruffnote.get(url) # reload!; r = Ruffnote.new; r.get_pages をやると
  end 
end
