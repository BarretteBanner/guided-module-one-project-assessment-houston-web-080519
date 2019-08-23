
def intro
    prompt = TTY::Prompt.new
    a = Artii::Base.new :font => 'slant'
    puts a.asciify('The Ultimate Fighter')
    sleep(0.5)
    signuporsignin
end 

def signuporsignin
    prompt = TTY::Prompt.new(active_color: :blue)
    input1 = prompt.select("Select:", ["Sign Up", "Login"])
    if input1 == "Sign Up"
        makeusername
    else 
        loginusername
    end
end

def makeusername
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    array_of_usernames_signup = []
    emoji1 = prompt.decorate("👻 ")
    User.all.select do |user|
        array_of_usernames_signup.push(user.username)
    end
    $current_user = prompt.ask("Make a username:")
    if array_of_usernames_signup.include?($current_user) == false
        sleep(0.5)
        makepassword
    else
        prompt.say("Sorry, that username is already taken. Please try another!")
        prompt.ok(">> Enter")
        gets
        makeusername
    end
end

def makepassword
    prompt = TTY::Prompt.new(active_color: :blue)
    sex_filter = LanguageFilter::Filter.new matchlist: :profanity, replacement: :stars
    hate_filter = LanguageFilter::Filter.new matchlist: :hate, replacement: :stars
    emoji1 = prompt.decorate("👻 ")
    $password = prompt.mask("Make a password", mask: emoji1)
    if sex_filter.match?($password) || hate_filter.match?($password)
        prompt.say("Please input another password.")
        prompt.ok(">> Enter")
        gets
        makepassword
    else
        selectgender_trainer_create
    end
end

def selectgender_trainer_create
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    gender = prompt.select("Choose your gender", ["Male", "Female"])
    prompt = TTY::Prompt.new
    trainer = prompt.select("Choose your trainer.", ["Doc Louis", "Mickey Goldmill", "Red", "Lance"])
    new_user = User.create({
        :username => $current_user,
        :trainer_name => trainer,
        :energy => 100,
        :money => 0,
        :flex => 1,
        :str => 1,
        :end => 1,
        :fights_won => 0,
        :weeks_trained => 0,
        :injured => false,
        :password => $password,
        :gender => gender,
        :level => 1
    })

        saveuser

end

def loginusername
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    username = nil
    array_of_usernames_login = []
    username = prompt.ask("What is your username?")
    User.all.select do |user|
        array_of_usernames_login.push(user.username)
    end
    if array_of_usernames_login.include?(username) == false
        prompt.say("Sorry that username doesn't exist.")
        prompt.ok(">> Enter")
        gets
        signuporsignin
    else 
        $current_user = username
        loginpassword
    end
end  

def loginpassword
    prompt = TTY::Prompt.new(active_color: :blue)
    checkpassword = nil
    emoji1 = prompt.decorate("👻 ")

    User.all.each do |user|
        user.username == $current_user
        checkpassword = user.password
    end

    $password = prompt.mask("Enter your password:", mask: emoji1)
    if $password == checkpassword
        saveuser
    else
        $current_user = nil
        prompt.say("Sorry, you've entered the wrong password")
        prompt.ok(">> Enter")
        gets
        signuporsignin
    end
end 

def saveuser
    User.all.each do |user|
        if user.username == $current_user
            $user = user 
            $user.level = 1
            $user.money = 0
        end
    end
    goodluck  
end

def goodluck
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    prompt.say("You're all set. Good luck!")
    start_game = prompt.select("Are You Ready?", ["START GAME"])
    if start_game == "START GAME"
        progressbar = ProgressBar.create(:title => "Loading", :starting_at => 0, :total => 100, :progress_mark => "█")
        100.times {progressbar.increment; sleep(0.03)}
    end
end



def mainmenu 
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    input9 = prompt.select("Main Menu:", ["Stats", "Fight", "Train", "Help"])
    if input9 == "Stats"
        stats
    elsif input9 == "Fight"
        gotofight
    elsif input9 == "Train"
        gotrain
    elsif input9 == "Help"
        help
    end
end

def stats
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    prompt.say("Money: #{$user.money}")
    prompt.say("Energy: #{$user.energy}")
    prompt.say("Strength: #{$user.str}")
    prompt.say("Flexibility: #{$user.flex}")
    prompt.say("Endurance: #{$user.end}")
    prompt.say("Trainer: #{$user.trainer_name}")
    prompt.say("Weeks Trained: #{$user.weeks_trained}")
    prompt.say("Fights Won: #{$user.fights_won}")
    prompt.say("Inured: #{$user.injured}")
    prompt.say("Gender: #{$user.gender}")
    prompt.say("Level:  #{$user.level}")
    input10 = prompt.select("Ready to go back?", ["Back"])
    if input10 == "Back"
        mainmenu
    end
end




def help
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    choosehelp = prompt.select("CHOOSE AN OPTION:", ["What Does Training Do?", "How Do Fights Work?", "About The Creators", "Back"])
    if choosehelp == "What Does Training Do?"
        traininghelp
    elsif choosehelp == "How Do Fights Work?"
        fighthelp
    elsif choosehelp == "About The Creators"
        about
    elsif choosehelp == "Back"
        mainmenu
    end
end


def traininghelp
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    sleep(0.5)
    prompt.say("This simulates your training before every fight. Your trainer will give you a list of workouts to do.")
    prompt.ok(">> Enter")
    gets
    prompt.say("We had an idea of someone integrating your stats/moves when you 'train', but alas no.")
    prompt.ok(">> Enter")
    gets
    4.times do
        print "."
        sleep(0.5)
      end
    prompt.say("\nI'm sad just thinking about what could have been")
    prompt.ok(">> Enter")
    gets
    choosehelp = prompt.select("Ready to go back?", ["Back"])
    if choosehelp == "Back"
        help
    end
end

def fighthelp
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    prompt.say("It’s a turned-based combat system like pokemon!")
    prompt.ok(">> Enter")
    gets
    prompt.say("Your moves (and your opponents) do X damage.")
    prompt.ok(">> Enter")
    gets
    prompt.say("If you run out of energy before your opponent, you lose and have to restart the game.")
    prompt.ok(">> Enter")
    gets
    choosehelp = prompt.select("Ready to go back?", ["Back"])
    if choosehelp == "Back"
        help
    end
end

def about
    puts `clear`
    prompt = TTY::Prompt.new(active_color: :blue)
    prompt.say("Created by Michael Evans and Barrette Banner")
    prompt.say("We are students at the Flatiron School of Houston.")
    prompt.say("We were inspired by games like Pokémon and Punchout and wanted to see if we could create our own twist in a CLI applicaiton.")
    prompt.say("When we're not at our desk, you can find us on the 10th floor enjoying the free beer and ping-pong.")
    prompt.say("The score is at least 1-0 to Michael, but who really keeps count ;)")
    choosehelp = prompt.select("Ready to go back?", ["Back"])
    if choosehelp == "Back"
        help
    end
end
