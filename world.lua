SYLLABLES = 
  "LEXEGEZACEBISOUSESARMAINDIREA?ERATENBERALAVETIEDORQUANTEI" ..
  "SRION"

function prng(a, b, c)
  return function()
    a, b, c = b, c, (a + b + c) % 65536
    return a, b, c
  end
end

function first(n, iterator)
  return function()
    if 0 < n then
      n = n - 1
      return iterator()
    end
  end
end

function skip(n, iterator)
  return function()
    for i = 1, n do
      iterator()
    end
    return iterator()
  end
end

function syllable(c)
  local x = math.floor(c / 256) % 32
  if x == 0 then
    return ""
  end
  x = 2 * x
  local s = SYLLABLES:sub(x - 1, x)
  if s:sub(2) == "?" then
    return s:sub(1, 1)
  end
  return s
end

function star(a, b, c)
  local name = syllable(c)
  for a, b, c in first(
    math.floor(a / 64) % 2 + 2,
    prng(a, b, c)
  ) do
    name = name .. syllable(c)
  end
  return {
    x = math.floor(b / 256),
    y = math.floor(a / 512),
    name = name
  }
end

function galaxy(a, b, c)
  local g = { star(a, b, c) }
  for a, b, c in first(255, skip(3, prng(a, b, c))) do
    table.insert(g, star(a, b, c))
  end
  return g
end
