
package com.mycompany.jv24_spring_project_final.controller;

import com.mycompany.jv24_spring_project_final.common.PasswordUtil;
import com.mycompany.jv24_spring_project_final.entities.UserEntity;
import com.mycompany.jv24_spring_project_final.entities.UserRoleEntity;
import com.mycompany.jv24_spring_project_final.enums.Role;
import com.mycompany.jv24_spring_project_final.service.UserRoleService;
import com.mycompany.jv24_spring_project_final.service.UserService;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRoleService userRoleService;
    
    @Autowired
    private JavaMailSender mailSender;
    
    @RequestMapping(value = {"user/", "user/home"})
    public String home(Model model) {
        return "redirect:/home";
    }
    
    @RequestMapping(value = {"login"}, method = RequestMethod.GET)
    public String login(Model model, @RequestParam(name = "error", required = false) String error) {
        if (error != null && !error.isEmpty() && error.equals("loginFail")) {
            model.addAttribute("message", "Email hoặc mật khẩu của bạn chưa chính xác!");
        }
        return "login";
    }
    
    @RequestMapping(value = {"/register"}, method = RequestMethod.GET)
    public String register(Model model) {
        model.addAttribute("user", new UserEntity());
        return "register";
    }
    
    @RequestMapping(value = "/register-handle", method = RequestMethod.POST)
    public String registerHandle(Model model, @ModelAttribute(value = "user") UserEntity user, @ModelAttribute(value = "password") String password) {
        if (userService.findByEmail(user.getEmail())!= null) {
            model.addAttribute("message", "Email của bạn đã tồn tại. Xin vui lòng nhập lại!");
            return "register";
        } else {
            List<UserRoleEntity> lstRole = new ArrayList<>();
            lstRole.add(userRoleService.findByRole(Role.ROLE_USER));
            
            user.setUserRole(lstRole);
            user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
            user.setActive(Boolean.TRUE);
            user = userService.save(user);
            
            if (user.getId() > 0 && user != null) {
                String subject = "Your Account";
                String message = "You have been registered successfully. Use this information to login: " + "Your email: " + user.getEmail() + ". " + "Your password: " + password.length() + " characters.";
                SimpleMailMessage mail = new SimpleMailMessage();
                mail.setTo(user.getEmail());
                mail.setSubject(subject);
                mail.setText(message);
                mailSender.send(mail);
                return "login";
            } else {
                model.addAttribute("message", "Bạn chưa đăng kí tài khoản thành công.");
                return "register";
            }
        }
        
    }

}
