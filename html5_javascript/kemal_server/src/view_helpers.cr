
def if_present_with_break(value, add_this_before = "")
  if value.to_s.size > 0 && value != 0
    add_this_before + " " + value.to_s + "<br/>"
  end
end

def table_row_or_nothing(first_cell, second_cell)
  if second_cell.to_s.size > 0 && second_cell != 0
    "<tr><td>#{first_cell}</td><td>#{second_cell}</td></tr>";
  end
end

def google_search_string(url)
   google_search = URI.escape(url.name + " poster", true)
   if url.episode_number != 0
     google_search += URI.escape(" " + url.episode_number.to_s + " " + url.episode_name, true)
   end
   google_search
end

def is_mobile(env)
  ua = env.request.headers["User-Agent"]? 
  ua =~ /Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile|Kindle|NetFront|Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|Dolphin|Skyfire|Zune/
end

def my_android?(env)
  ua = env.request.headers["User-Agent"]? 
  ua =~ /PlayItMyWayUndroid/
end

def editor?(env)
  if logged_in?(env)
    logged_in_user(env).editor
  else
    false
  end
end

def admin?(env)
  logged_in?(env) && logged_in_user(env).admin
end

def tags_by_category(url)
  url.tags.group_by{|tag| tag.category}.select{|category, tags| tags.size > 1 }.map{|category, tags| 
    category = "clothing/kissing etc" if category == "physical"
    category = "language" if category == "profanity"
    category = "substance use" if category == "substance-abuse"
    "#{category}: #{tags.size}"
  }.join(", ")
end
