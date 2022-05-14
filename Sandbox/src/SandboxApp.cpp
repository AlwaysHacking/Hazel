#include <Hazel.h>

#include "imgui/imgui.h"

class ExampleLayer : public Hazel::Layer
{
public:
	ExampleLayer()
		: Layer("Example")
	{
	}

	void OnUpdate() override
	{
	
	}

	void OnEvent(Hazel::Event& event) override
	{
        
	}
    
	virtual void OnImGuiRender() override
	{
		ImGui::Begin("Test");
        ImGui::Text("Hello World!");
        ImGui::End();
	}
};

class Sandbox : public Hazel::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
	}

	~Sandbox()
	{
	
	
	}

};

Hazel::Application* Hazel::CreateApplication()
{
	return new Sandbox();
}
