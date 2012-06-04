# This Rack middleware helps solving the issue with some Rails versions which do not accept
# a '*/*;q=0.6' and their variants 'Accept' request header. This header is particularly used
# by Google Bot, and if Rails doesn't like it, it will return a 500 or 406 error to Google Bot,
# which is not the best way to get your pages indexed.
#
# References:
#   - http://stackoverflow.com/questions/8881756/googlebot-receiving-missing-template-error-for-an-existing-template
#   - https://github.com/rails/rails/issues/4127
#
class GoogleBotAware

  def initialize(app)
    @app = app
  end

  def call(env)
    # If the request 'Content Accept' header indicates a '*/*' format,
    # we set the format to :html.
    # This is necessary for GoogleBot which requests / with '*/*;q=0.6' for example.
    if env["HTTP_ACCEPT"] =~ %r%\*\/\*;q=\d\.\d%
       env["HTTP_ACCEPT"] = '*/*'
    end

    @app.call(env)
  end

end
