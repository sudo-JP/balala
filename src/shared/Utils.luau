local higherOrderFunctions = {}

function higherOrderFunctions.arrayFilter<T>(array: {T}, lambda: (T) -> boolean)
    local filterdTable = {}
    for _, value in ipairs(array) do
        if lambda(value) then
            table.insert(filterdTable, value)
        end
    end
    return filterdTable
end

function higherOrderFunctions.inplaceRandomizeArray<T>(array: {T})
    for i = #array, 2, -1 do
        local j = math.random(1, i)
        array[i], array[j] = array[j], array[i]
    end
end

function higherOrderFunctions.isInBound<T>(array: {T}, index: number)
    if index < 1 or index > #array then
        return false
    end
    return true
end

function higherOrderFunctions.arraySlice<T>(array: {T}, startIndex: number, endIndex: number)
    local sliced = {}
    if startIndex > endIndex 
        or not higherOrderFunctions.isInBound(array, startIndex) 
        or not higherOrderFunctions.isInBound(array, endIndex)
    then
        return sliced
    end
    for i = startIndex, endIndex do
        table.insert(sliced, array[i])
    end

    return sliced
end

function higherOrderFunctions.arrayLeftFold<T, U>(array: {T}, acc: U, lambda: (U, T) -> U): U
    for _, value in ipairs(array) do
        acc = lambda(acc, value)
    end
    return acc
end

function higherOrderFunctions.arrayHasElement<T>(array: {T}, lambda: (T) -> boolean): boolean
    for _, value in ipairs(array) do
        if lambda(value) then
            return true
        end
    end
    return false
end

return higherOrderFunctions
