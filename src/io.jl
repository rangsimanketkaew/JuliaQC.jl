function read_xyz(ifile::String)
    """
    Reads in an xyz file of possibly multiple geometries, returning the header, atom labels, 
    and coordinates as arrays of strings and Float64s for the coordinates.
    """
    @time file_contents = readlines(ifile)
    header = Array{String, 1}()
    atom_labels = Array{Array{String, 1}, 1}()
    geoms = Array{Array{Float64, 2}, 1}()
    for (i, line) in enumerate(file_contents)
        if isa(tryparse(Int, line), Int)
            # allocate the geometry for this frame
            N = parse(Int, line)
            head = string(N)
            labels = String[]
            # store the header for this frame
            head = string(line, file_contents[i+1])
            i += 1
            push!(header, head)
            # loop through the geometry storing the vectors and atom labels as you go
            geom = zeros((3, N))
            for j = 1:N
                coords = split(file_contents[i+1])
                i += 1
                push!(labels, coords[1])
                geom[:,j] = parse.(Float64, coords[2:end])
            end
            push!(geoms, geom)
            push!(atom_labels, labels)
        end
    end
    return header, atom_labels, geoms
end

number, labels, geoms = read_xyz("C:\\Users\\Nutt\\Desktop\\github\\JuliaCC.jl\\test\\xyz\\benzene.xyz")
print(number)
print(labels)
println(geoms)