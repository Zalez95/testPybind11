#include <iostream>
#include <pybind11/embed.h>

namespace py = pybind11;


struct PODParam
{
	float a, b;
};


float additionCPP(float a, float b)
{
	return a + b;
}


PYBIND11_EMBEDDED_MODULE(myModule, m) {
	m.def("additionCPP", &additionCPP);
}


int main()
{
	std::cout << "C++ Hello" << std::endl;

	try {
		py::scoped_interpreter guard{};
		py::exec(R"(
			print("Python Hello")
		)");
		auto exampleModule = py::module::import("scripts");
		auto f = exampleModule.attr("sayHello");
		f();

		auto f2 = exampleModule.attr("addition");
		std::cout << "Result f2: " << f2(2.0f, 4.0f).cast<float>() << std::endl;

		auto f3 = exampleModule.attr("additionCPP");
		std::cout << "Result f3: " << f2(3.0f, 6.0f).cast<float>() << std::endl;
	}
	catch (const py::error_already_set& e) {
		std::cerr << e.what() << std::endl;
	}

	return 0;
}
