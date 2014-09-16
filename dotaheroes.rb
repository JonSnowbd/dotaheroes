module Dotaheroes

    @hero_data = 'data/heroes/'

    def Dotaheroes.Mine(hero)
        if File.exist?(@hero_data + hero.downcase + '.hinfo')
            return hero.capitalize
        else
            return "Hero data not found."
        end
    end

end

puts Dotaheroes::Mine('aBaddon')
