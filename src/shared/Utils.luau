local higherOrderFunctions = {}

function arrayFilter<T>(array: {T}, lambda: (T) -> boolean)
    local filterdTable = {}
    for _, value in ipairs(array) do
        if lambda(value) then
            table.insert(filterdTable, value)
        end
    end
    return filterdTable
end
higherOrderFunctions.arrayFilter = arrayFilter

function inplaceRandomizeArray<T>(array: {T})
    for i = #array, 2, -1 do
        local j = math.random(1, i)
        array[i], array[j] = array[j], array[i]
    end
end
higherOrderFunctions.inplaceRandomizeArray = inplaceRandomizeArray

function isInBound<T>(array: {T}, index: number)
    if index < 1 or index > #array then
        return false
    end
    return true
end

function arraySlice<T>(array: {T}, startIndex: number, endIndex: number)
    local sliced = {}
    if startIndex > endIndex 
        or not isInBound(array, startIndex) 
        or not isInBound(array, endIndex)
    then
        return sliced
    end
    for i = startIndex, endIndex do
        table.insert(sliced, array[i])
    end

    return sliced
end


higherOrderFunctions.arraySlice = arraySlice

return higherOrderFunctions
