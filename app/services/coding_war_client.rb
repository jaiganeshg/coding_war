class CodingWarClient < ApiClient
  USERNAME = 'swiss_knife'
  SECRET = 'swiss_knife'
  BASE_URL = 'http://demo7524716.mockable.io/'
  UP = 'UP'
  DOWN = 'DOWN'
  LEFT = 'LEFT'
  RIGHT = 'RIGHT'

  @@server_secret = nil
  @@board_state = nil

  def self.server_secret
    @@server_secret
  end

  def self.board_state
    @@board_state
  end

  def login
    url = build_url('/login')
    payload = {secret: SECRET, username: USERNAME}
    response = api_call(:post, url, { header: DEFAULT_HEADERS, body: payload.to_json }, true)
    @@server_secret = response['usersecret']
  end

  def move(direction)
    url = build_url('/move')
    payload = {secret: SECRET,
               username: USERNAME,
               usersecret: @@server_secret,
               direction: direction
    }
    response = api_call(:post, url, { header: DEFAULT_HEADERS, body: payload.to_json }, true)
    @@board_state = response
  end

  def status
    url = build_url("/status/#{SECRET}")
    response = api_call(:get, url, { header: DEFAULT_HEADERS }, true)
    @@board_state = response
  end

  def fire(direction)
    url = build_url('/fire')
    payload = {secret: SECRET,
               username: USERNAME,
               usersecret: @@server_secret,
               direction: direction
    }
    response = api_call(:post, url, { header: DEFAULT_HEADERS, body: payload.to_json }, true)
    @@board_state = response
  end

  def place_bomb
    url = build_url('/place_bomb')
    payload = {secret: SECRET,
               username: USERNAME,
               usersecret: @@server_secret
    }
    response = api_call(:post, url, { header: DEFAULT_HEADERS, body: payload.to_json }, true)
    @@board_state = response
  end

  private
  def build_url(path)
    URI.join(BASE_URL, path).to_s
  end
end