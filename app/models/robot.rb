class Robot < ActiveRecord::Base
  attr_accessible :receive, :reply, :username

  NullReply = 'You gotta say something.'
  ChineseReply = 'Sorry I can\'t speak Chinese.'

  class << self
    def dump
      File.open('lib/programr/lib/cache/init.cache','w') do |file|
        marshal = Marshal.dump($robot.graph_master, -1).force_encoding('utf-8')
        file.write(marshal)
      end
    end

    def learn(pattern, template)
      str = "<category>\n" \
        << "<pattern>" << pattern.upcase << "</pattern>\n" \
        << "<template>\n" \
        << template \
        << "\n</template>\n" \
        << "</category>\n\n" \
        << "</aiml>"

        text = IO.read './lib/programr/lib/aiml/my.aiml'
        text.gsub! '</aiml>', str
      File.open('./lib/programr/lib/aiml/my.aiml','w') do |f|
        f << text
      end
      $robot.parser.parse text
    end

    def reply receive
      if receive.blank?
        reply = NullReply
      elsif receive =~ /[\u4e00-\u9fa5]/
        reply = ChineseReply
      elsif Crawler.is_wiki_question?(receive).present?
        puts '====is wiki question!========='
        puts "to robot:"
        reply = $robot.get_reaction receive
        puts "from robot:" + reply.to_s
        if reply.blank?
          reply = get_reply_from_wiki receive
        end
        if reply.blank?
          puts "to last:"
          reply = $robot_last.get_reaction receive
          puts "from last: " + reply
        end
      else
        puts "to robot:"
        reply = $robot.get_reaction receive
        puts "from robot:" + reply.to_s
        if reply.blank?
          puts "to last:"
          reply = $robot_last.get_reaction receive
          puts "from last: " + reply
        end
      end
      return reply
    end

    def get_reply_from_wiki receive
      wiki_word= Crawler.get_wiki_word(receive)

      reply = Crawler.find_in_wiki wiki_word
    end

  end
end
