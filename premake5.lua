workspace "Hazel"
    architecture "x64"
    startproject "Sandbox"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"


-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"
IncludeDir["Glad"] = "Hazel/vendor/Glad/include"
IncludeDir["ImGui"] = "Hazel/vendor/imgui"
IncludeDir["glm"] = "Hazel/vendor/glm"

include "Hazel/vendor/GLFW"
include "Hazel/vendor/Glad"
include "Hazel/vendor/imgui"

project "Hazel"
    location "Hazel"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
        "%{prj.name}/vendor/glm/glm/**.hpp",
        "%{prj.name}/vendor/glm/glm/**.inl"
    }

    defines
    {
        "_CRT_SECURE_NO_WARNINGS"
    }

    includedirs
    {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}"
    }

    filter "system:windows"
        staticruntime "On"
        systemversion "latest"
        
        pchheader "hzpch.h"
        pchsource "Hazel/src/hzpch.cpp"

        defines
        {
            "HZ_PLATFORM_WINDOWS",
            "HZ_BUILD_DLL",
            "GLFW_INCLUDE_NONE"
        }

        postbuildcommands
        {
            ("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
        }

        links
        {
            "GLFW",
            "Glad",
            "ImGui",
            "opengl32.lib"
        }

    filter "system:macosx"
        pchheader "src/hzpch.h"
        pchsource "src/hzpch.cpp"

        postbuildcommands {
            ("cp -R %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
        }

        defines
        {
            "GLFW_INCLUDE_NONE"
        }

        sysincludedirs {
            "%{IncludeDir.GLFW}",
            "%{IncludeDir.Glad}",
            "%{IncludeDir.ImGui}",
            "%{IncludeDir.glm}",
            "%{prj.name}/src",
            "%{prj.name}/vendor/spdlog/include"
        }

        links
        {
            "GLFW",
            "Glad",
            "ImGui"
        }
  
    filter "configurations:Debug"
        defines "HZ_DEBUG"
        runtime "Debug"
        symbols "On"
  
    filter "configurations:Release"
        defines "HZ_RELEASE"
        runtime "Release"
        symbols "On"
  
    filter "configurations:Dist"
        defines "HZ_DIST"
        runtime "Release"
        symbols "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "Hazel/vendor/spdlog/include",
        "Hazel/src",
        "Hazel/vendor",
        "%{IncludeDir.glm}"
    }

    filter "system:windows"
        staticruntime "On"
        systemversion "latest"

        links
        {
            "Hazel"
        }

        defines
        {
            "HZ_PLATFORM_WINDOWS"
        }

    filter "system:macosx"
        sysincludedirs
        {
            "Hazel/vendor/spdlog/include",
            "Hazel/src",
            "Hazel/vendor",
            "%{IncludeDir.glm}"
        }

        links
        {
            "Hazel",
            "Cocoa.framework",
            "IOKit.framework",
            "CoreFoundation.framework",
            "OpenGL.framework"
        }

    filter "configurations:Debug"
        defines "HZ_DEBUG"
        runtime "Debug"
        symbols "On"
  
    filter "configurations:Release"
        defines "HZ_RELEASE"
        runtime "Release"
        symbols "On"
  
    filter "configurations:Dist"
        defines "HZ_DIST"
        runtime "Release"
        symbols "On"