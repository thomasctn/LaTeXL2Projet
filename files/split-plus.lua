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
