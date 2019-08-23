require 'pry'
def realfightinfo
    puts `clear`
    puts "current health BEFORE#{$health}"
    $health *= $user.level
    puts "current health #{$health}"
    prompt = TTY::Prompt.new(active_color: :blue)
    Opponent.all.select do |opponent|
        if $user.level == opponent.level
            $current_opponent = opponent
        end
    end
    prompt.say("#{$user.trainer_name}: Your opponent is #{$current_opponent.name}.")
    $opponent_health = $current_opponent.energy
    prompt.ok(">> Enter")
    gets
    choosefight = prompt.select("Select:", ["Opponent Info","Start Fight"])
    $opponent_full_health = $opponent_health
    if choosefight == "Opponent Info"
        opponentinfo
    else
        choosemoves
    end
end

def opponentinfo
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    if $current_opponent.name == "Chuck Cianwood"
        prompt.say("#{$user.trainer_name}: This fight is going to be tough. Chuck eats newbies like you up over at his gym.")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: If your not careful, he's got a mean uppercut that's going to knock your ass out.")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Stay on your toes, and work on what we practiced.")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Good luck!")
        prompt.ok(">> Enter")
        gets
    elsif $current_opponent.name == "Brawly Dewford"
        prompt.say("#{$user.trainer_name}: Brawly might seem tiny compared to the last guy, but he's twice as fast!")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: He punches at lightning speeds and is known KO move is his High Jump Kick\n")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: If you can avoid that, then you should be good!\n")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Good luck!")
        prompt.ok(">> Enter")
        gets
    elsif $current_opponent.name == "Maylene Veilstone"
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Maylene is a fierce competitor. She studies her opponents extensively.")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Since you've been making a name for yourself, expect your opponents from here on out to study your moveset and skills")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: My only advice is don't get hit with her knee. I've seen her fracture men's skulls without hesitation")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Good luck!")
        prompt.ok(">> Enter")
        gets
    elsif $current_opponent.name == "Korrina Shalour"
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Your opponent's name is Korrina Shalour. She is also looking for a chance to fight the champion.")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: My sources tell me she's paid off the ref so your chances are slim.")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Don't let her get in your head. This is going to be a mental battle as much as it is a physical one.")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Good luck kid. I believe in you!")
        prompt.ok(">> Enter")
        gets
    elsif $current_opponent.name == "Mike Tyson"
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Alright champ, this is it. The baddest motherfucker to walk into the cage. Mike Tyson")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: This is all you kid. Now get out there!")
        sleep(1.3)
        prompt.say("#{$user.trainer_name}: Good luck.")
        prompt.ok(">> Enter")
        gets
    end
    sleep(0.75)
    choosefight = prompt.select("Ready To Start", ["Back"])
    if choosefight == "Back"
        choosemoves
    end
end

def choosemoves
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :red)
    array_all_moves = []
    case $user.level
    when 1
        Moveset.all.select do |m|
            if m.level == 1
                array_all_moves.push(m.moves)
                $opponent_move_choices.push(m.moves)
            end
        end
    when 2
        Moveset.all.select do |m|
            if  m.level == 1
                array_all_moves.push(m.moves)
            end
            if m.level == 2
                array_all_moves.push(m.moves)
                $opponent_move_choices.push(m.moves)
            end
        end
    when 3
        Moveset.all.select do |m|
            if  m.level == 1
                array_all_moves.push(m.moves)
            end
            if m.level == 2
                array_all_moves.push(m.moves)
            end
            if m.level == 3
                array_all_moves.push(m.moves)
                $opponent_move_choices.push(m.moves)
            end
        end
    when 4
        Moveset.all.select do |m|
            if  m.level == 1
                array_all_moves.push(m.moves)
            end
            if m.level == 2
                array_all_moves.push(m.moves)
            end
            if m.level == 3
                array_all_moves.push(m.moves)
            end
            if m.level == 4
                array_all_moves.push(m.moves)
                $opponent_move_choices.push(m.moves)
            end
        end
    when 5
        Moveset.all.select do |m|
            array_all_moves.push(m.moves)
        end
        Moveset.all.select do |m|
            if m.level == 5
                $opponent_move_choices.push(m.moves)
            end
        end
    else
        "end"
    end

    choices = array_all_moves
    prompt.say("Use 'Spacebar' to select your moves and 'Enter' when you are done!")
    prompt.ok(">> Enter")
    gets
    $array_user_moves_choices = prompt.multi_select("Select 4 moves", choices, max: 4)
    if $array_user_moves_choices.count == 4
        prompt.say("#{$user.trainer_name}: QUOTE FROM TRAINER CLASS")
        globalvariablesforfight
    else
        prompt.say("oops! looks like you hit 'Enter' before selecting all your moves. No worries!")
        prompt.ok(">> Enter")
        gets
        choosemoves
    end
end
### start
def globalvariablesforfight
    $array_uppercut = ["Uppercut","Uppercut"]
    $array_highjumpkick = ["High Jump Kick","High Jump Kick"]
    $array_kneeofjustice = ["Knee of Justice","Knee of Justice"]
    $array_uchimata = ["Uchi Mata","Uchi Mata"]
    $array_skullcrusher = ["Skull Crusher","Skull Crusher"]

    $array_jab = ["Jab"]
    $array_righthook = ["Right Hook"]
    $array_focuspunch = ["Focus Punch"]
    $array_hammerfist = ["Hammerfist"]
    $array_rearnakedchoke = ["Rear-Naked Choke"]
    
    trainer_phrases_all = []
    $fightphrases = []
    Trainer.all.each do |trainer|
    if trainer.name == "Red"
        trainer_phrases_all << trainer.phrase3 && trainer_phrases_all << trainer.phrase8 && trainer_phrases_all << trainer.phrase9 
    end
    end
    $fightphrases = trainer_phrases_all.uniq
    makemove 
end

def makemove
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    if $user_miss == 0
        prompt.say("#{$current_user} missed!")
    end
    if $user_injured_multiplier == 0.2
        prompt.error("You are injured! Your damage multiplier has changed.")
        sleep(1.5)
    end
    if $health >= $opponent_full_health * 0.75
        prompt.ok("#{$user.trainer_name}: Your health is at #{$health}")
    elsif $health >= $opponent_full_health * 0.45
        prompt.warn("#{$user.trainer_name}: Your health is at #{$health}")
    else
        prompt.error("#{$user.trainer_name}: Your health is at #{$health}")
    end
    sleep(1.0)
    if $opponentmiss == 0
        prompt.say("Your opponent missed!")
    end
    if $opponent_injured_multiplier == 0.2
        prompt.error("Your opponent is injured! Their damage multiplier has changed.")
        sleep(1.5)
    end
    if $opponent_health >= $opponent_full_health * 0.75
        prompt.ok("#{$user.trainer_name}: Your opponent's health is at #{$opponent_health}")
    elsif $opponent_health >= $opponent_full_health * 0.45
        prompt.warn("#{$user.trainer_name}: Your opponent's health is at #{$opponent_health}")
    else
        prompt.error("#{$user.trainer_name}: Your opponent's health is at #{$opponent_health}")
    end    
    sleep(1.0)
    $array_recent_power_moves = [$array_uppercut, $array_highjumpkick, $array_kneeofjustice, $array_uchimata, $array_skullcrusher].reduce([], :concat)
    $array_recent_strength_moves = [$array_jab, $array_righthook, $array_focuspunch, $array_hammerfist, $array_rearnakedchoke].reduce([], :concat)

    $array_available_moves = []
    $array_user_moves_choices.each do |move|
        if $array_recent_power_moves.include?(move) == false && $array_recent_strength_moves.include?(move) == false
            $array_available_moves << move
        end
    end
    $array_available_moves_opponent = []
    $opponent_move_choices.each do |move|
        if $array_recent_power_moves.include?(move) == false && $array_recent_strength_moves.include?(move) == false
            $array_available_moves_opponent << move
        end
    end
    if $fightphrases.last
        prompt.say("#{$user.trainer_name}: #{$fightphrases.last}")
        $fightphrases.pop
    end
    #add stuff for if all power moves
    user_attack = prompt.select("Choose a move!", $array_available_moves)
    $array_uppercut.pop 
    $array_highjumpkick.pop 
    $array_kneeofjustice.pop 
    $array_uchimata.pop
    $array_skullcrusher.pop 

    $array_jab.pop
    $array_righthook.pop
    $array_focuspunch.pop
    $array_hammerfist.pop
    $array_rearnakedchoke.pop

    if user_attack == "Uppercut"
        $array_uppercut << "Uppercut"
    elsif user_attack == "High Jump Kick"
        $array_highjumpkick << "High Jump Kick"
    elsif user_attack == "Knee of Justice"
        $array_kneeofjustice << "Knee of Justice"
    elsif user_attack == "Uchi Mata"
        $array_uchimata << "Uchi Mata"
    elsif user_attack == "Skull Crusher"
        $array_skullcrusher << "Skull Crusher"
    elsif user_attack == "Jab"
        $array_jab << "Jab"
    elsif user_attack == "Right Hook"
        $array_righthook << "Right Hook"
    elsif user_attack == "Focus Punch"
        $array_focuspunch << "Focus Punch"
    elsif user_attack == "Hammerfist"
        $array_hammerfist << "Hammerfist"
    elsif user_attack == "Rear-Naked Choke"
        $array_rearnakedchoke << "Rear-Naked Choke"
    end
#here

miss_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
$user_miss = 1
$opponentmiss = 1
injured_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
$user_injured_multiplier = 1
$opponent_injured_multiplier = 1
if miss_array.sample > 16
    $user_miss = 0
end

if miss_array.sample > 12
    $opponentmiss = 0
end

if injured_array.sample > 19
    $user.injured = true
    $user_injured_multiplier = 0.2
end

if injured_array.sample > 19
    $opponent_injured_multiplier = 0.2
end

    Moveset.all.select do |m|
        if user_attack == m.moves
            $opponent_health -= (m.damage * $user_miss * $user_injured_multiplier)
            $opponent_health.round
        end
    end
    if $opponent_health <= 0
        $opponent_health = 0
        userwins
    else
        opponent_attack = $array_available_moves_opponent.sample 
        Moveset.all.select do |m|
            if opponent_attack == m.moves
                $health -= (m.damage * $opponentmiss * $opponent_injured_multiplier)
                $health.round
            end
        end
    end 
    if $health <= 0
        $health = 0
        userloses
    else 
        makemove
    end
end

def userwins
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    $user.level += 1
    $user.injured = false
    prompt.say("#{$user.trainer_name}: You knocked em out cold! What a fight...")
    sleep(1.0) 
    prompt.say("#{$user.trainer_name}: You've leveled up! You're now level #{$user.level}!")
    sleep(1.0)
    $user.money += ($health * 100)
    $health = 100
    afterwin
end

def userloses
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :red)
    $user.money += ($health * 100)
    high_score = $user.money
    prompt.say("You lost :( Better luck next time! Here is your highscore: #{high_score}")
    prompt.ok(">> Enter")
    gets
    new_highscore = Highscore.create({
        :username => $user.username,
        :date => DateTime.now,
        :highscore => high_score
    })
    thanksforplaying
end

def afterwin
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :red)
    if $user.level == 6
        prompt.say("#{$user.trainer_name}: Congrats you've won the game!")
        sleep(2.0)
        high_score = $user.money
        new_highscore = Highscore.create({
            :username => $user.username,
            :date => DateTime.now,
            :highscore => high_score
    })
        thanksforplaying
    else
        prompt.say("#{$user.trainer_name}: Great job #{$current_user}! You've passed level #{$user.level - 1}.")
        prompt.say("#{$user.trainer_name}: Only #{6 - $user.level} to go!")
        $user.flex += 5
        $user.str += 5
        $user.end += 5
        choosewhenready = prompt.select("Select:", ["Continue"])
        if choosewhenready == "Continue"
            progressbar = ProgressBar.create(:title => "Loading", :starting_at => 0, :total => 100, :progress_mark => "█")
            100.times {progressbar.increment; sleep(0.03)}
            mainmenu
        end
    end
end

def thanksforplaying
    prompt = TTY::Prompt.new
    sleep(0.75)
    print "."
    sleep(0.1)
    print "."
    sleep(0.1)
    print ".\n"
    sleep(0.6)
    prompt.say("Thank you for playing our game")
    sleep(1.0)
    prompt.say("Barrette and I had a lot of fun making it and we are so excited to be able to share it with you.")
    sleep(1.0)
    prompt.say("<3")
    exit
end