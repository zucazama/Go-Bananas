function table.unpack(a, i, j)
    local i = i or 1
    local j = j or #a

    if i == j then return a[i]
    else return a[i], table.unpack(a, i + 1, j) end
end