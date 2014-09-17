# Main Module name space
module Dotaheroes

    @hero_data = 'data/heroes/'

    # Get the path to the heroes .hinfo
    def Dotaheroes.path(heroname)
        return @hero_data + heroname.downcase.tr('_', '') + '.hinfo'
    end

    # Check if there is a .hinfo for the corresponding hero
    def Dotaheroes.exist?(heroname)
        if File.exist?(Dotaheroes.path(heroname))
            return true
        else
            return false
        end
    end

    # List all heroes
    def Dotaheroes.list()
        @temp = Dir.entries(@hero_data).select {|f| !File.directory? f}
        @temp.map!{ |item| item.chomp('.hinfo') }
        return { :heroes => @temp }
    end

    # Retrieve hero info from .hinfo files.
    def Dotaheroes.mine(heroname)

        if Dotaheroes.exist?(heroname)

            # Open the file
            @file = File.open(Dotaheroes.path(heroname)).read

            #Substitute weird line end feeds into standard linux \n feed.
            @file.gsub!(/\r\n?/, "\n")

            @temp = {}

            #File found, mine it line by line for information to return.
            @file.each_line do |line|

                # Get the first letter, the command identifier.
                @command = line.split(' ')[0].to_s[0]

                # After the first letter, where the data goes.
                @target = line.split(' ')[0].to_s[1..-1]

                # Get content without the quotations
                @content = /(["])(?:(?=(\\?))\2.)*?\1/.match(line).to_s[1..-2]

                # Handle Static variable declarations
                if @command == '>'
                    @temp[:"#{@target}"] = @content
                end

                # Handle array variable declarations
                if @command == '!'

                    if @temp[:"#{@target}"].is_a?(Array)

                        @temp[:"#{@target}"] << @content

                    else

                        # If its not an array then make it and feed the content in.
                        @temp[:"#{@target}"] = []
                        @temp[:"#{@target}"] << @content

                    end

                end

            end


            return @temp

        else

            return "Hero data not found for " + heroname + "."

        end

    end
end

if __FILE__ == $0
    Dotaheroes.list()
end
