def all_genres # obviously DB must sync here :|
  ["romance/chick flick", "romantic comedy", "animation/cartoon", "documentary", "horror", "action/adventure", "western", "military/war", "comedy", "music/musical", "drama", "sports", "holiday", "fantasy", "sci-fi", "mystery/thriller", "faith/spirituality"].sort
end

def editing_phases # DB sync necessary
 {just_started: "Just started, tags might not be fully complete yet", done_first_pass: "Done with first pass tagging, could use second review", done_second_pass: "Done with second review, tags viewed as complete"}
end

# if you change any names in this method be careful that any auto scan subs need to match it [you can tell by doing a single upload]
def subcategory_map
  {
"movie-content": {
  {db_name: "initial theme song", human_name: "initial theme song", sub_sub_cat: ""},
  {db_name: "initial credits", human_name: "initial company credits before intro/before songs", sub_sub_cat: ""},
  {db_name: "closing credits", human_name: "closing credits/songs", sub_sub_cat: ""},
  {db_name: "subscription plea", human_name: "closing subscription plea", sub_sub_cat: ""},
  {db_name: "joke edit", human_name: "joke edit", sub_sub_cat: ""},
  {db_name: "movie content morally questionable choice", human_name: "morally questionable choice", sub_sub_cat: ""},
  {db_name: "movie note for viewer", human_name: "movie note/message for viewer", sub_sub_cat: ""},
  {db_name: "movie content other", human_name: "other", sub_sub_cat: ""},
},
"profanity": {
  {db_name: "loud noise", human_name: "loud noise/screaming/yelling", sub_sub_cat: ""},
  {db_name: "raucous music", human_name: "raucous music", sub_sub_cat: ""},
  {db_name: "personal insult mild", human_name: "insult (\"moron\", \"idiot\" etc.)", sub_sub_cat: ""},
  {db_name: "personal attack mild", human_name: "attack command (\"shut up\" etc.)", sub_sub_cat: ""},
  {db_name: "being mean", human_name: "being mean/cruel to another", sub_sub_cat: ""},
  {db_name: "derogatory slur", human_name: "categorizing derogatory slur", sub_sub_cat: ""},
  {db_name: "crude humor", human_name: "crude humor, like poop, bathroom, gross, etc.", sub_sub_cat: ""},
  {db_name: "bodily part reference mild", human_name: "bodily part reference mild (butt, bumm, suck...)", sub_sub_cat: ""},
  {db_name: "bodily part reference harsh", human_name: "bodily part reference harsh (balls, etc.)", sub_sub_cat: ""},
  {db_name: "sexual reference", human_name: "sexual innuendo/reference", sub_sub_cat: ""},
  {db_name: "violence reference", human_name: "violence reference", sub_sub_cat: ""},
  {db_name: "euphemized profanities", human_name: "euphemized profanities (ex: crap, dang, gosh dang)", sub_sub_cat: ""},
  {db_name: "lesser expletive", human_name: "other lesser expletive ex \"bloomin'\" etc.", sub_sub_cat: ""},
  {db_name: "deity religious context", human_name: "deity use in religious context like \"the l... is good\"", sub_sub_cat: ""},
  {db_name: "deity reference", human_name: "deity use appropriate but non religious context like \"in this game you are G...\"", sub_sub_cat: ""},
  {db_name: "deity exclamation mild", human_name: "deity exclamation mild like Good L...", sub_sub_cat: ""},
  {db_name: "deity exclamation euphemized", human_name: "deity euphemized like 'oh my gosh'", sub_sub_cat: ""},
  {db_name: "deity exclamation harsh", human_name: "deity exclamation harsh, name of the Lord (omg, etc.)", sub_sub_cat: ""},
  {db_name: "deity expletive", human_name: "deity expletive (es: goll durn, the real words)", sub_sub_cat: ""},
  {db_name: "deity greek", human_name: "deity greek (Zeus, etc.)", sub_sub_cat: ""},
  {db_name: "deity foreign language", human_name: "deity different language, like Allah or French equivalents, etc", sub_sub_cat: ""},
  {db_name: "personal insult harsh", human_name: "insult harsh (son of a ..... etc.)", sub_sub_cat: ""},
  {db_name: "a word", human_name: "a.. (and/or followed by anything)", sub_sub_cat: ""},
  {db_name: "d word", human_name: "d word", sub_sub_cat: ""},
  {db_name: "h word", human_name: "h word", sub_sub_cat: ""},
  {db_name: "h word in context", human_name: "h word original meaning", sub_sub_cat: ""},
  {db_name: "s word", human_name: "s word", sub_sub_cat: ""},
  {db_name: "f word", human_name: "f-bomb expletive", sub_sub_cat: ""},
  {db_name: "f word sex connotation", human_name: "f-bomb sexual connotation", sub_sub_cat: ""},
  {db_name: "profanity foreign language", human_name: "any other profanity different language, French, etc", sub_sub_cat: ""},
  {db_name: "profanity (other)", human_name: "other", sub_sub_cat: ""},
},
"violence": {
  {db_name: "light fight", human_name: "short fighting (single punch/kick/hit/push)", sub_sub_cat: ""},
  {db_name: "sustained fight", human_name: "sustained punching/fighting", sub_sub_cat: ""},
  {db_name: "threatening actions", human_name: "threatening actions", sub_sub_cat: ""},
  {db_name: "stabbing/shooting no blood", human_name: "stabbing/shooting no blood", sub_sub_cat: ""},
  {db_name: "stabbing/shooting with blood", human_name: "stabbing/shooting yes blood", sub_sub_cat: ""},
  {db_name: "visible blood", human_name: "visible blood (ex: blood from wound)", sub_sub_cat: ""},
  {db_name: "visible wound", human_name: "visible wound (no gore, light gore)", sub_sub_cat: ""},
  {db_name: "open wounds", human_name: "visible gore (ex: open wound)", sub_sub_cat: ""},
  {db_name: "crudeness", human_name: "crude actions, grossness, etc.", sub_sub_cat: ""},
  {db_name: "collision", human_name: "collision/crash (no implied death)", sub_sub_cat: ""},
  {db_name: "collision death", human_name: "collision/crash (implied death)", sub_sub_cat: ""},
  {db_name: "explosion", human_name: "explosion (no implied death)", sub_sub_cat: ""},
  {db_name: "explosion death", human_name: "explosion (implied death)", sub_sub_cat: ""},
  {db_name: "comedic fight", human_name: "comedic/slapstick fighting", sub_sub_cat: ""},
  {db_name: "shooting miss", human_name: "shooting miss or ambiguous", sub_sub_cat: ""},
  {db_name: "shooting hit non death", human_name: "shooting hits person or thing but non fatal", sub_sub_cat: ""},
  {db_name: "killing", human_name: "killing on screen (ex: shooting death fatal)", sub_sub_cat: ""},
  {db_name: "attempted killing", human_name: "attempted killing on screen (ex: laser zap)", sub_sub_cat: ""},
  {db_name: "non human killing", human_name: "non human killing/death on screen (ex: animal, or robot)", sub_sub_cat: ""},
  {db_name: "killing offscreen", human_name: "killing off screen (ex: shooting death off screen)", sub_sub_cat: ""},
  {db_name: "circumstantial death", human_name: "death non-killing, ex: accidental falling", sub_sub_cat: ""},
  {db_name: "hand gesture", human_name: "hand gesture", sub_sub_cat: ""},
  {db_name: "sports violence", human_name: "sports violence part of game", sub_sub_cat: ""},
  {db_name: "rape", human_name: "rape", sub_sub_cat: ""},
  {db_name: "dead body", human_name: "dead body visible lifeless", sub_sub_cat: ""},
  {db_name: "suicidal actions", human_name: "suicidal actions", sub_sub_cat: ""},
  {db_name: "creepy", human_name: "creepy/horror/unsettling", sub_sub_cat: ""},
  {db_name: "violence (other)", human_name: "other", sub_sub_cat: ""},
},
"physical": {
  {db_name: "art nudity", human_name: "art based nudity", sub_sub_cat: ""},
  {db_name: "revealing clothing", human_name: "revealing clothing (scantily clad)", sub_sub_cat: ""},
  {db_name: "tight clothing", human_name: "tight clothing (revealing because tight)", sub_sub_cat: ""},
  {db_name: "underwear", human_name: "clad in underwear", sub_sub_cat: ""},
  {db_name: "swimsuit", human_name: "swimsuit", sub_sub_cat: ""},
  {db_name: "light cleavage", human_name: "light cleavage/barely revealing", sub_sub_cat: ""},
  {db_name: "revealing cleavage", human_name: "revealing cleavage", sub_sub_cat: ""},
  {db_name: "partial nudity", human_name: "partial nudity (ex: excessive cleavage)", sub_sub_cat: ""},
  {db_name: "nudity posterior male", human_name: "nudity (posterior) male", sub_sub_cat: ""},
  {db_name: "nudity posterior female", human_name: "nudity (posterior) female", sub_sub_cat: ""},
  {db_name: "nudity anterior male", human_name: "nudity (anterior) male", sub_sub_cat: ""},
  {db_name: "nudity anterior female", human_name: "nudity (anterior) female", sub_sub_cat: ""},
  {db_name: "nudity breast", human_name: "nudity (breast)", sub_sub_cat: ""},
  {db_name: "shirtless male", human_name: "shirtless male (non sexual)", sub_sub_cat: ""},
  {db_name: "kissing peck", human_name: "kiss (peck)", sub_sub_cat: ""},
  {db_name: "kissing passionate", human_name: "kiss (passionate)", sub_sub_cat: ""},
  {db_name: "sexually charged scene", human_name: "sexually charged scene", sub_sub_cat: ""},
  {db_name: "sex foreplay", human_name: "sex foreplay", sub_sub_cat: ""},
  {db_name: "implied sex", human_name: "implied sex", sub_sub_cat: ""},
  {db_name: "explicit sex", human_name: "explicit sex", sub_sub_cat: ""},
  {db_name: "homosexual behavior", human_name: "homosexual behavior (kissing, holding hands, light stuff)", sub_sub_cat: ""},
  {db_name: "physical (other)", human_name: "other", sub_sub_cat: ""},
},
"substance-abuse": {
  {db_name: "alcohol", human_name: "alcohol drinking", sub_sub_cat: ""},
  {db_name: "smoking", human_name: "smoking legal stuff (cigar, cigarette)", sub_sub_cat: ""},
  {db_name: "smoking illegal", human_name: "smoking illegal drugs", sub_sub_cat: ""},
  {db_name: "drugs", human_name: "illegal drug use", sub_sub_cat: ""},
  {db_name: "drug injection", human_name: "drug use injection", sub_sub_cat: ""},
  {db_name: "substance-abuse other", human_name: "other", sub_sub_cat: ""},
},
"suspense": {
  {db_name: "frightening/startling scene/event", human_name: "frightening/startling scene/event", sub_sub_cat: ""},
  {db_name: "suspenseful fight \"will they win?\"", human_name: "suspenseful fight \"will they win?\"", sub_sub_cat: ""},
  {db_name: "suspense other", human_name: "other", sub_sub_cat: ""},
},

}
end
