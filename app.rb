require 'sinatra'

# configure block is a Sinatra feature
configure do
    @@nouns = File.open('nouns.txt').map{|line|
        line.strip.downcase
    }
end


def nurble(text)
    text = text.upcase
    words = text.downcase().gsub(/[^a-z ]/, '').split

    words.each{|w|
        if not @@nouns.include? w
          pattern = Regexp.new('(\b)'+ w + '(\b)', Regexp::IGNORECASE)
          replacement = "\1<span class=\"nurble\">nurble</span>\2"
          text.gsub! pattern, replacement
        end
    }
    text.gsub(/\n/, '<br>')
end


get "/" do
    haml :index
end


post "/nurble" do
    haml :nurble, :locals => {
      :text => nurble(params["text"])
    }
end
