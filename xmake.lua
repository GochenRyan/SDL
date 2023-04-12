target("libSDL")
    add_includedirs(
        "$(projectdir)/Vendor/SDL/include/"
    )

    on_build("windows", function(target)
        os.cd("$(projectdir)/Vendor/SDL")
        if (is_mode("debug"))
        then
            os.run("cmake -B build -D CMAKE_BUILD_TYPE=Debug")
            os.run("cmake --build build")
        else
            os.run("cmake -B build -D CMAKE_BUILD_TYPE=Release")
            os.run("cmake --build build")
        end
        os.cd("$(projectdir)")
    end)

    after_build("windows", function(target)
        os.cp("$(projectdir)/Vendor/SDL/build/Debug/*.lib", "$(projectdir)/lib/")
        os.trymv("$(projectdir)/lib/SDL3d.lib", "$(projectdir)/lib/libSDL.lib")
        os.trymv("$(projectdir)/lib/SDL3.lib", "$(projectdir)/lib/libSDL.lib")

        os.cp("$(projectdir)/Vendor/SDL/build/Debug/*.dll", "$(projectdir)/lib/")
        os.trymv("$(projectdir)/lib/SDL3d.dll", "$(projectdir)/lib/libSDL.dll")
        os.trymv("$(projectdir)/lib/SDL3.dll", "$(projectdir)/lib/libSDL.dll")

        os.cp("$(projectdir)/Vendor/SDL/build/Debug/*.pdb", "$(projectdir)/lib/")
        os.trymv("$(projectdir)/lib/SDL3d.pdb", "$(projectdir)/lib/libSDL.pdb")
        os.trymv("$(projectdir)/lib/SDL3.pdb", "$(projectdir)/lib/libSDL.pdb")
    end)

    on_clean("windows", function(target)
        os.cd("$(projectdir)/Vendor/SDL")
        if os.exists("$(buildir)") then
            os.rm("$(buildir)/")
        end
        os.cd("$(projectdir)")
    end)
    