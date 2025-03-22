local notify = require('notify')

local function create_file(path, content)
    local file = io.open(path, "w")
    if file then
        file:write(content)
        file:close()
        notify("✅ Created: " .. path, "info")
    else
        notify("❌ Error creating file: " .. path, "error")
    end
end

local function create_folder(path)
    os.execute("mkdir -p " .. path)
    notify("📁 Created folder: " .. path, "info")
end

local function create_project_structure()
    local folders = {
        "lib/app/bindings",
        "lib/app/controllers",
        "lib/app/data/models",
        "lib/app/middlewares",
        "lib/app/routes",
        "lib/app/services",
        "lib/app/ui/screens",
        "lib/app/ui/widgets",
        "lib/core/config",
        "lib/core/helpers"
    }
    for _, folder in ipairs(folders) do
        create_folder(folder)
    end
end

local function snake_case_to_pascal_case(str)
    return str:gsub("(%a)([%w_]*)", function(a, b) return a:upper() .. b:gsub("_", "") end)
end

local function generate_controller(name)
    local class_name = snake_case_to_pascal_case(name) .. "Controller"
    local content = string.format([[import 'package:get/get.dart';

class %s extends GetxController {
}]], class_name)
    create_file("lib/app/controllers/" .. name .. "_controller.dart", content)
end

local function generate_binding(name)
    local class_name = snake_case_to_pascal_case(name) .. "Binding"
    local controller_name = snake_case_to_pascal_case(name) .. "Controller"
    local content = string.format([[import 'package:get/get.dart';
import '../controllers/%s_controller.dart';

class %s extends Bindings {
    @override
    void dependencies() {
        Get.lazyPut<%s>(() => %s());
    }
}]], name, class_name, controller_name, controller_name)
    create_file("lib/app/bindings/" .. name .. "_binding.dart", content)
end

local function generate_model(name)
    local class_name = snake_case_to_pascal_case(name)
    local content = string.format([[class %s {
    %s();
    
    factory %s.fromJson(Map<String, dynamic> json) => %s();
    
    Map<String, dynamic> toJson() => {};
}]], class_name, class_name, class_name, class_name)
    create_file("lib/app/data/models/" .. name .. "_model.dart", content)
end

local function generate_screen(name)
    local class_name = snake_case_to_pascal_case(name) .. "Screen"
    local controller_name = snake_case_to_pascal_case(name) .. "Controller"
    local content = string.format([[import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/%s_controller.dart';

class %s extends GetView<%s> {
    const %s({super.key});
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text("%s Screen")),
            body: Center(child: Text("Welcome to %s")),
        );
    }
}]], name, class_name, controller_name, class_name, class_name, class_name)
    create_file("lib/app/ui/screens/" .. name .. "_screen.dart", content)
end

vim.api.nvim_create_user_command("GenerateController", function(opts) generate_controller(opts.args) end, { nargs = 1 })
vim.api.nvim_create_user_command("GenerateBinding", function(opts) generate_binding(opts.args) end, { nargs = 1 })
vim.api.nvim_create_user_command("GenerateModel", function(opts) generate_model(opts.args) end, { nargs = 1 })
vim.api.nvim_create_user_command("GenerateScreen", function(opts) generate_screen(opts.args) end, { nargs = 1 })
vim.api.nvim_create_user_command("GenerateFolders", function() create_project_structure() end, {})

--notify("🚀 GetX Generator Loaded Successfully!", "info")

