#pragma once

#if HZ_DYNAMIC_LINK
    #ifdef HZ_BUILD_DLL
        #define HAZEL_API __declspec(dllexport)
    #else
        #define HAZEL_API __declspec(dllimport)
    #endif
#else
    #define HAZEL_API
#endif

#ifdef HZ_DEBUG
    #define HZ_ENABLE_ASSERTS
#endif

// TODO change __debugbreak() to cross platform
#ifdef HZ_ENABLE_ASSERTS
    #define HZ_ASSERT(x, ...) { if (!(x)) { HZ_ERROR("Assertion Failed: {0}", __VA_ARGS__); } }
    #define HZ_CORE_ASSERT(x, ...) { if (!(x)) { HZ_CORE_ERROR("Assertion Failed: {0}", __VA_ARGS__); } }
#else
    #define HZ_ASSERT(x, ...)
    #define HZ_CORE_ASSERT(x, ...)
#endif

#define BIT(x) (1 << x)

#define HZ_BIND_EVENT_FN(fn) std::bind(&fn, this, std::placeholders::_1)
