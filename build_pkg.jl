t = Template(;
    user="tomouellette",
    authors="Tom W Ouellette",
    julia=v"1.6.3",
    plugins=[
        License(; name="MIT"),
        Git(; manifest=true, ssh=true),
        TravisCI(; linux = true, osx = true, x64 = true, x86 = true),
    ],
)

generate("EmulatE.jl",t)
