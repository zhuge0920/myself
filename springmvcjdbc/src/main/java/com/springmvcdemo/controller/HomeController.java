package com.springmvcdemo.controller;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import com.springmvcdemo.model.Msg;
import com.springmvcdemo.service.UserService;
import com.springmvcdemo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
//表明这个类是个控制器，这意味着我们需要在-servelt.xml中配置一个context:component-scan来
//<!--指明controller 所在包，并扫描其中的注解 -->
/**
 *
 * @RequestMapping 表示只要是/hello.action的请求，就交由该方法处理。当然了.action可以去掉
 * @param model 它和ModelAndView类似，它这个Model就是把数据封装到request对象中，我们就可以获取出来
 * @return 返回跳转的页面【真实路径，也可以配置视图解析器了】
 * @throws Exception
 */
public class HomeController {
    // 自动装配数据库接口，不需要再写原始的Connection来操作数据库
    //注入角色服务对象
    @Autowired
    private UserService userService;

    //@RequestMapping(value = "/", method = RequestMethod.GET)
   // public String index() {
        //return "index";
    //}

    /*
     *  1、@ResponseBody令数据不会被解析，而是直接写入HTTP response body中
     *    （比如异步获取JSON数据就要用到这个）
     *  2、想要@ResponseBody正常工作，需要导入jackson包。这个
     *     包负责将对象转化为JSON字符串
     */
    @RequestMapping("/")
    public String index(){
        return "/index";
    }
    //查询员工分页
    @RequestMapping(value = "/admin/users", method = RequestMethod.GET)
    @ResponseBody
    public Msg getUsers(@RequestParam(value="pn",defaultValue = "1")Integer pn){
        //查处所有员工但不是分页
        //引入分页插件
        //在查询之前只需要调用如下方法，从第n页查，每次查5条数据
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<User> user=userService.getAll();
        PageHelper.clearPage();
        //将查询到的所有数据利用pageInfo进行包装，
        //可以显示一些信息（比如在第几页啥的）；此处的5表示连续显示的页数
        PageInfo<User> pageInfo =new PageInfo<>(user,5);
        //model.addAttribute("pageInfo",page);
        return Msg.success().add("pageInfo",pageInfo);
    }
    /*
    @RequestMapping(value = {"/admin/user"}, method = {RequestMethod.GET})
    public String getEmpList(ModelMap modelMap){

        //ModelAndView mv = new ModelAndView("admin/list");
        //获取第1页，10条内容
        //PageHelper.startPage(pn, 5);
        List<User> userList  = userService.getAll();

        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
       // PageInfo<User> pageInfo = new PageInfo<>(user, 5);
        modelMap.addAttribute("userList",userList);
        return "admin/users";
    }
    */




    /*
    public String getUsers(ModelMap modelMap) {
        // 查询user表中所有记录
        List<User> userList = userService.getAll();

        // 将所有记录传递给要返回的jsp页面，放在userList当中
        modelMap.addAttribute("userList", userList);
        //return "redirect:./admin/users";

        // 返回pages目录下的admin/users.jsp页面
        return "admin/users";
    }
    */

    // get请求，访问添加用户 页面
    @RequestMapping(value = "/admin/users/add", method = RequestMethod.GET)
    public String addUser() {
        // 转到 admin/addUser.jsp页面
        return "admin/addUser";
    }

    // post请求，处理添加用户请求，并重定向到用户管理页面
    //使用@RequestParam来接收参数。
    @RequestMapping(value = "/admin/users/addP", method = RequestMethod.POST)
    @ResponseBody
    public Map addUserPost(@RequestBody User user) {
        // 数据库中添加一个用户
        userService.insert(user);
        // 重定向到用户管理页面，方法为 redirect:url
        Map<String, String> s = new HashMap<>();
        s.put("code", "200");
        s.put("msg", "我出错了");
        return s;
    }

    // 查看用户详情
    // @PathVariable可以收集url中的变量，需匹配的变量用{}括起来
    // 例如：访问 localhost:8080/admin/users/show/1 ，将匹配 id = 1
    /*@RequestMapping(value="/admin/users/show/{id}",method=RequestMethod.GET)
    //注解@PathVariable从URL请求地址中获取参数
    public String showDetail(@PathVariable("userId") Integer userId,ModelMap modelMap){
        //
        //找到userId所表示的用户
        User user=userService.findId(userId);
        //传递给请求页面
        modelMap.addAttribute("user",user);
        return "admin/userDetail";
    }
*/
    /*@RequestMapping(value = "/admin/users/show/{id}",method = RequestMethod.GET)
    public String getUser(@PathVariable("id") Integer id){

         userService.findId(id);

        return"/admin/updateUser";
    }
    */

    // 更新用户信息
    @RequestMapping(value ="/admin/users/show/{id}", method = RequestMethod.GET)
    public String updateUser(@PathVariable("id") Integer id, ModelMap modelMap) {

        // 找到userId所表示的用户
        User user=userService.findId(id);

        // 传递给请求页面
        modelMap.addAttribute("user",user);
        return "/admin/updateUser";
    }

    // 更新用户信息 操作

    @RequestMapping(value = "/admin/users/updateP", method = RequestMethod.PUT)
    @ResponseBody
    public Map updateUserPut( @RequestBody User user) {
        userService.update(user);
        Map<String, String> s = new HashMap<>();
        s.put("code","200");
        s.put("msg","我出错了");

        return s;
    }

    // 删除用户
    @RequestMapping(value = "/admin/user/delete/{id}", method = RequestMethod.DELETE)
   public Map deleteUser(@PathVariable("id") Integer id) {

        // 删除id为userId的用户
        userService.deleteById(id);
        Map<String,String> s=new HashMap<>();
        s.put("code","200");
        s.put("msg","我出错了");
        return s;
    }

}