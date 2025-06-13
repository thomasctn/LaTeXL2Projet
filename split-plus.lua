command_a = {} ;

function mk_array_plus(filename,line_separator)
  numbers_a = {"one","two","three","four","five","six","seven","eight"} ;
  local default_input = io.input() ; io.input(filename) ;
  if line_separator ~= "" then line_separator = "\\" .. line_separator ;
  end ;
  local case = {} ;
  local index = 1 ;
  for line in io.lines() do
    case = string.explode(line," +") ;
    for j = 1,#case do
      case[j] = string.gsub(case[j],",","{,}") ;
      if j == #case and i == #line then tex.print(case[j] .. " \\\\") ;
      elseif j == #case then tex.print(case[j] .. " \\\\" .. line_separator) ;
      else tex.print(case[j] .. " & ") ;
      end ;
    end ;
    command_a[index] =
      "\\renewcommand{\\getarrayplus" .. numbers_a[index] .. "}{" ..
      case[#case] .. "}"
    index = index + 1 ;
  end ;
  io.input(default_input) ;
end ;

function put_renewcommands()
  for _,command_s0 in ipairs(command_a) do
    tex.print(command_s0) ;
  end ;
end ;


-- Utilitaire pour extraire l'âge moyen
function compute_average_age(filename, birthdate_column)
  local default_input = io.input()
  io.input(filename)

  local total_months = 0
  local count = 0

  for line in io.lines() do
    local fields = string.explode(line, " +")
    local date_str = fields[birthdate_column]

    -- Essayer de détecter différents formats de date
    local y, m, d = date_str:match("(%d%d%d%d)[-/](%d%d)[-/](%d%d)")
    if not y then
      y, d, m = date_str:match("(%d%d%d%d)[-/](%d%d)[-/](%d%d)")
    end
    if y then
      y, m, d = tonumber(y), tonumber(m), tonumber(d)

      -- Date cible : 1er juin 2025
      local birth = os.time({year = y, month = m, day = d})
      local target = os.time({year = 2025, month = 6, day = 1})

      if birth and target and birth < target then
        local diff = os.difftime(target, birth) / (60 * 60 * 24 * 30.44)  -- Approx mois
        total_months = total_months + diff
        count = count + 1
      end;
    end;
  end;

  io.input(default_input)

  if count > 0 then
    local avg_months = total_months / count
    local avg_years = math.floor(avg_months / 12)
    local avg_remaining_months = math.floor(avg_months % 12)
    tex.print(string.format("%d ans et %d mois", avg_years, avg_remaining_months))
  else
    tex.print("Âge moyen non disponible")
  end;
end;
