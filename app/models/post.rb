class Post
  include Mongoid::Document
  
  field :pid, type: Integer
  field :tid, type: Integer
  field :uid, type: Integer
  field :order, type: Integer
  field :message, type: String
  field :posttime, type: DateTime
    
  def self.do_search(search)
    @result = []
    doc = Post.mongo_session.command(text: 'posts', search: normalize_query(search.q))
    doc["results"].each do |r|
      @result << Post.new(r["obj"])
    end
    @result
  end
  
  private 
  
  def self.normalize_query(raw)
    if raw.scan(/"/).count % 2 == 1
       raw[raw.rindex(/"/)] = ' '
    end
    arr = []
    in_quote = false
    in_token = false
    token = ""
    
    raw.each_char do |c| 
      if c == '"'
        if in_quote
          token = token.strip + c
          arr << token
          token = ""
          in_token = false
          in_quote = false
        elsif in_token
          if token.start_with?('-') or token.start_with?('"')
            arr << token
          else
            arr << ('"' + token.strip + '"')
          end
          token = "\""
          in_quote = true
        else
          token = "\""
          in_token = true
          in_quote = true
        end
      elsif c =~ /\s/
        if in_quote
          token += ' ' unless token.end_with?(' ')
        elsif in_token
          if token.start_with?('-') or token.start_with?('"')
            arr << token
          else
            arr << ('"' + token.strip + '"')
          end
          token = ""
          in_token = false
        end
      else
        token += c
        in_token = true
      end
    end
    
    if in_token
      if token.start_with?('-')
        arr << token
      else
        arr << ('"' + token.strip + '"')
      end
    end
    
    arr.join(' ')
  end
end
