package com.mycompany.jv24_spring_project_final.controller;

import com.mycompany.jv24_spring_project_final.common.PasswordUtil;
import com.mycompany.jv24_spring_project_final.entities.BookTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieScheduleEntity;
import com.mycompany.jv24_spring_project_final.entities.TicketDetailEntity;
import com.mycompany.jv24_spring_project_final.entities.UserEntity;
import com.mycompany.jv24_spring_project_final.entities.UserRoleEntity;
import com.mycompany.jv24_spring_project_final.enums.Gender;
import com.mycompany.jv24_spring_project_final.enums.Role;
import com.mycompany.jv24_spring_project_final.service.MovieService;
import com.mycompany.jv24_spring_project_final.service.TicketService;
import com.mycompany.jv24_spring_project_final.service.UserService;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private MovieService movieService;
    @Autowired
    private UserService userService;
    @Autowired
    private TicketService ticketService;

    @RequestMapping(value = {"/", "/home"})
    public String home(Model model, @RequestParam(value = "message", required = false) String message, @RequestParam(value = "page", defaultValue = "1", required = false) int page) {
        model.addAttribute("lstMovie", movieService.findAll(new PageRequest(page - 1, 7)));
        model.addAttribute("lstCategoryMovie", movieService.getCategoryMovie());
        model.addAttribute("page", page);
        model.addAttribute("message", message);
        return "admin/home";
    }

    @RequestMapping(value = {"/user"}, method = RequestMethod.GET)
    public String getUser(Model model, @RequestParam(value = "message", required = false) String message) {
        model.addAttribute("message", message);
        model.addAttribute("lstUser", userService.getUser());
        return "admin/user";

    }

    @RequestMapping(value = {"/trang2"}, method = RequestMethod.GET)
    public String trang2(Model model, @RequestParam(value = "message", required = false) String message) {
        List<MovieEntity> lstM = movieService.getMovie();
        List<MovieEntity> lstMovie = new ArrayList<>();
        for (int i = 0; i < lstM.size(); i++) {
            if (i > 5) {
                lstMovie.add(lstM.get(i));
            }
        }
        model.addAttribute("lstMovie", lstMovie);
        model.addAttribute("message", message);
        return "admin/home";
    }

    @RequestMapping(value = {"/add-movie"}, method = RequestMethod.GET)
    public String viewFormMovie(Model model, HttpSession session) {
        model.addAttribute("action", "save-movie");
        model.addAttribute("lstCountryMovie", movieService.getCountry());
        model.addAttribute("lstCategoryMovie", movieService.getCategoryMovie());

        return "admin/movie-form";
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public String upload(Model model, HttpServletRequest request,
            @RequestParam(value = "fileUpload", required = false) MultipartFile fileUpload, HttpSession session) {
        //String path = "D:\\Jv24\\Spring Framework\\JV24_Spring_Project_Final\\JV24_Spring_Project_Final\\src\\main\\webapp\\resources\\images\\";
        String path = "E:\\Senior Project\\senior_project\\JV24_Spring_Project_Final\\src\\main\\webapp\\resources\\images";
        //String path = "http://node194476-cinemaxxi.jelastic.servint.net/home/src/main/webapp/resources/images/";
        File uploadRootDir = new File(path);
        String imagesupload = fileUpload.getOriginalFilename();
        if (imagesupload != null) {

            try {
                // Tạo thư mục gốc upload nếu nó không tồn tại.
                if (!uploadRootDir.exists()) {
                    uploadRootDir.mkdirs();
                }
                File images = new File(uploadRootDir.getAbsolutePath() + File.separator + imagesupload);
                FileOutputStream stream = new FileOutputStream(images);
                stream.write(fileUpload.getBytes());
//                fileUpload.transferTo(images);
                stream.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        model.addAttribute("imagesupload", imagesupload);
        model.addAttribute("lstCountryMovie", movieService.getCountry());
        model.addAttribute("lstCategoryMovie", movieService.getCategoryMovie());

        model.addAttribute("action", "save-movie");
        return "admin/movie-form";

    }

    @RequestMapping(value = "/save-movie", method = RequestMethod.POST)
    public String saveMovie(Model model, @ModelAttribute(value = "movies") MovieEntity movies, HttpSession session) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("nameAdmin", ((UserEntity) principal).getFullName());
        MovieEntity movie = movieService.saveMovie(movies);
        if (movie != null && movie.getId() > 0) {
            return "redirect:/admin/home?message=Ban da them phim thanh cong!";
        } else {
            return "redirect:/admin/add-movie?message=Ban da them phim that bai!";
        }
    }

    @RequestMapping(value = "/edit-movie/{id}")
    public String editMovie(Model model, @PathVariable(value = "id") int movieId, HttpSession session) {

        model.addAttribute("action", "update-movie");
        model.addAttribute("movie", movieService.findByIdMovie(movieId));
        model.addAttribute("lstCountryMovie", movieService.getCountry());
        model.addAttribute("lstCategoryMovie", movieService.getCategoryMovie());

        return "admin/movie-form";
    }

    @RequestMapping(value = "/update-movie", method = RequestMethod.POST)
    public String updateMovie(Model model, @ModelAttribute(value = "movies") MovieEntity movies, HttpSession session) {
        MovieEntity movie = movieService.saveMovie(movies);
        if (movie != null && movie.getId() > 0) {
            return "redirect:/admin/home?message=Ban da cap nhat phim thanh cong!";
        } else {
            return "redirect:/admin/edit-movie?message=Ban da cap nhat phim that bai!";
        }
    }

    @RequestMapping(value = "/searchMovie", method = RequestMethod.POST)
    public String searchCriteria(Model model, @ModelAttribute(value = "searchText") String searchText,
            @RequestParam(value = "page", defaultValue = "1", required = false) int page, HttpSession session) {
        model.addAttribute("lstMovie", movieService.searchNameMovie(searchText, new PageRequest(page - 1, 7)));
        model.addAttribute("lstCategoryMovie", movieService.getCategoryMovie());
        model.addAttribute("page", page);
        return "admin/home";
    }

    @RequestMapping(value = "/deleteMovie/{id}")
    public String deleteMovie(Model model, @PathVariable(value = "id") int id) {
        if (movieService.checkExistMovie(id)) {
            if (movieService.deleteMovie(id)) {
                return "redirect:/admin/home?message=Ban da xoa phim that bai!";
            } else {
                return "redirect:/admin/home?message=Ban da xoa phim thanh cong!";

            }
        } else {
            return "redirect:/admin/home?message=Ban khong the xoa phim!";
        }
    }

    @RequestMapping(value = "/searchUser", method = RequestMethod.POST)
    public String searchUser(Model model, @ModelAttribute(value = "searchText") String searchText, HttpSession session) {
        List<UserEntity> lstUser = userService.searchUser(searchText);
        model.addAttribute("lstUser", lstUser);
        return "admin/user";
    }

//    @RequestMapping(value = "/categoryMovie", method = RequestMethod.POST)
//    public String categoryMovie(Model model, @ModelAttribute(value = "categoryMovie.id") int categoryMovie, @RequestParam(value = "page", defaultValue = "1", required = false) int page) {
//        List<MovieEntity> lstMovie = movieService.categoryMovie(categoryMovie, new PageRequest(page - 1, 7));        
//        model.addAttribute("lstMovie", lstMovie);
//        model.addAttribute("lstCategoryMovie", movieService.getCategoryMovie());
//        model.addAttribute("page", page);
//        return "admin/home";
//    }
    @RequestMapping(value = "/add-user")
    public String viewFormUser(Model model) {
        model.addAttribute("genders", Gender.values());
        model.addAttribute("lstroles", userService.getUserRole());
        model.addAttribute("action", "save-user");

        return "admin/user-form";
    }

    @RequestMapping(value = "/save-user", method = RequestMethod.POST)
    public String saveUser(Model model, @ModelAttribute(value = "user") UserEntity user, HttpServletRequest request, @RequestParam(value = "role") int roleId) {
        if (userService.findByEmail(user.getEmail()) != null) {
            model.addAttribute("genders", Gender.values());
            model.addAttribute("message", "Email của bạn đã tồn tại. Xin vui lòng nhập lại!");
            return "admin/user-form";
        }
        List<UserRoleEntity> lstRole = new ArrayList<>();
        lstRole.add(userService.findByRoleId(roleId));
        user.setUserRole(lstRole);
        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        user.setActive(Boolean.TRUE);
        UserEntity users = userService.saveUser(user);

        if (users != null && users.getId() > 0) {
            return "redirect:/admin/user?message=Ban da them tai khoan thanh cong!";
        } else {
            return "redirect:/admin/add-user?message=Ban da them tai khoan that bai!";
        }
    }

    @RequestMapping(value = "/edit-user/{id}")
    public String editUser(Model model, @PathVariable(value = "id") int userId, HttpSession session) {

        model.addAttribute("action", "update-user");
        model.addAttribute("user", userService.findByIdUser(userId));
        model.addAttribute("genders", Gender.values());
        model.addAttribute("lstroles", userService.getUserRole());

        return "admin/user-form";
    }

    @RequestMapping(value = "/update-user", method = RequestMethod.POST)
    public String updateUser(Model model, @ModelAttribute(value = "user") UserEntity user) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("nameAdmin", ((UserEntity) principal).getFullName());
        List<UserRoleEntity> lstRole = new ArrayList<>();
        lstRole.add(userService.findByRole(Role.ROLE_USER));
        user.setUserRole(lstRole);
        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        user.setActive(Boolean.TRUE);
        UserEntity users = userService.saveUser(user);

        if (users != null && users.getId() > 0) {
            return "redirect:/admin/user?message=Ban da cap nhat tai khoan thanh cong!";
        } else {
            return "redirect:/admin/add-movie";
        }
    }

    @RequestMapping(value = "/viewTicket")
    public String viewBookTicket(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("nameAdmin", ((UserEntity) principal).getFullName());

        List<BookTicketEntity> lstticket = ticketService.getBookTicket();
        List<TicketDetailEntity> lstTicketDetail = ticketService.getTicketDetail();
        if (lstticket != null && lstticket.size() > 0) {
            for (BookTicketEntity bookTicketEntity : lstticket) {
                List<TicketDetailEntity> lstT = new ArrayList<>();

                if (lstTicketDetail != null && lstTicketDetail.size() > 0) {
                    for (TicketDetailEntity ticketDetailEntity : lstTicketDetail) {
                        if (ticketDetailEntity.getBookTicket().getId() == bookTicketEntity.getId()) {
                            lstT.add(ticketDetailEntity);

                        }
                    }
                    bookTicketEntity.setTicketDetail(lstT);
                } else {
                    lstTicketDetail = (List<TicketDetailEntity>) new TicketDetailEntity();
                }

            }
        }
        model.addAttribute("lstTicket", lstticket);
        return "admin/list-ticket";
    }

    @RequestMapping(value = "/downloadExcel")
    public String downloadExcel(Model model) {

        List<BookTicketEntity> lstticket = ticketService.getBookTicket();
        List<TicketDetailEntity> lstTicketDetail = ticketService.getTicketDetail();
        if (lstticket != null && lstticket.size() > 0) {
            for (BookTicketEntity bookTicketEntity : lstticket) {
                List<TicketDetailEntity> lstT = new ArrayList<>();

                if (lstTicketDetail != null && lstTicketDetail.size() > 0) {
                    for (TicketDetailEntity ticketDetailEntity : lstTicketDetail) {
                        if (ticketDetailEntity.getBookTicket().getId() == bookTicketEntity.getId()) {
                            lstT.add(ticketDetailEntity);

                        }
                    }
                    bookTicketEntity.setTicketDetail(lstT);
                } else {
                    lstTicketDetail = (List<TicketDetailEntity>) new TicketDetailEntity();
                }

            }
        } else {
            lstticket = (List<BookTicketEntity>) new BookTicketEntity();
        }
        model.addAttribute("lstTicket", lstticket);
        return "excelView";
    }

    @RequestMapping(value = {"/movieschedule"}, method = RequestMethod.GET)
    public String getMovieSchedule(Model model, @RequestParam(value = "message", required = false) String message) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("nameAdmin", ((UserEntity) principal).getFullName());
        model.addAttribute("message", message);

        model.addAttribute("lstMovieSchedule", ticketService.getMovieSchedule());
        return "admin/movie-schedule";

    }

//    @RequestMapping(value = {"/searchmovieschedule"}, method = RequestMethod.POST)
//    public String searchMovieSchedule(Model model, @ModelAttribute(value = "searchText") String searchText) {
//        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        model.addAttribute("nameAdmin", ((UserEntity) principal).getFullName());
//        List<MovieEntity> lstMovie = movieService.searchNameMovie(searchText);
//        List<MovieScheduleEntity> lstMovieSch = (List<MovieScheduleEntity>) ticketService.getMovieSchedule();
//        List<MovieScheduleEntity> lstSearch = new ArrayList<>();
//        for (MovieEntity movieEntity : lstMovie) {
//            for (MovieScheduleEntity movieScheduleEntity : lstMovieSch) {
//                if (movieEntity.getId() == movieScheduleEntity.getMovie().getId()) {
//                    lstSearch.add(movieScheduleEntity);
//                }
//            }
//        }
//
//        model.addAttribute("lstMovieSchedule", lstSearch);
//        return "admin/result";
//
//    }
    @RequestMapping(value = "/deleteMovieSchedule/{id}")
    public String deleteMovieSchedule(Model model, @PathVariable(value = "id") int id) {
        if (ticketService.checkExistMovieSchedule(id)) {
            if (ticketService.deleteMovieSchedule(id)) {
                return "redirect:/admin/movieschedule?message=Ban da xoa lich chieu phim that bai!";
            } else {
                return "redirect:/admin/movieschedule?message=Ban da xoa lich chieu phim thanh cong!";

            }
        } else {
            return "redirect:/admin/movieschedule?message=Ban khong the xoa lich chieu phim!";
        }
    }

    @RequestMapping(value = "/add-movieSchedule")
    public String viewFormMovieSchidule(Model model) {
        model.addAttribute("lstMovie", movieService.getMovie());
        model.addAttribute("lstRoom", ticketService.getRoom());
        model.addAttribute("action", "save-movieSchedule");

        return "admin/movieSchedule-form";
    }

    @RequestMapping(value = "/save-movieSchedule", method = RequestMethod.POST)
    public String saveMovieSchedule(Model model, @ModelAttribute(value = "movieSchdule") MovieScheduleEntity movieSchedule, HttpSession session) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("nameAdmin", ((UserEntity) principal).getFullName());
        MovieScheduleEntity movie = ticketService.saveMovieSchedule(movieSchedule);
        if (movie != null && movie.getId() > 0) {
            return "redirect:/admin/movieschedule?message=Ban da them lich chieu phim thanh cong!";
        } else {
            return "redirect:/admin/add-movieSchedule?message=Ban da them lich chieu phim that bai!";
        }
    }

    @RequestMapping(value = "/edit-movieSchedule/{id}")
    public String editMovieSchedule(Model model, @PathVariable(value = "id") int movieId, HttpSession session) {

        model.addAttribute("action", "update-movieSchedule");
        model.addAttribute("movieSchedule", ticketService.findById(movieId));
        model.addAttribute("lstMovie", movieService.getMovie());
        model.addAttribute("lstRoom", ticketService.getRoom());

        return "admin/movieSchedule-form";
    }

    @RequestMapping(value = "/update-movieSchedule", method = RequestMethod.POST)
    public String updateMovieSchedule(Model model, @ModelAttribute(value = "movieSchdule") MovieScheduleEntity movieSchedule) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("nameAdmin", ((UserEntity) principal).getFullName());
        MovieScheduleEntity movie = ticketService.saveMovieSchedule(movieSchedule);
        if (movie != null && movie.getId() > 0) {
            return "redirect:/admin/movieschedule?message=Ban da cap nhat lich chieu phim thanh cong!";
        } else {
            return "redirect:/admin/edit-movieSchedule?message=Ban da xoa lich chieu phim that bai!";
        }
    }

    @RequestMapping(value = "/delete-user/{id}")
    public String deleteUser(Model model, @PathVariable(value = "id") int id) {
        if (userService.checkExistUser(id)) {
            if (userService.deleteUser(id)) {
                return "redirect:/admin/user?message=Ban da xoa lich chieu phim that bai!";
            } else {
                return "redirect:/admin/user?message=Ban da xoa lich chieu phim thanh cong!";

            }
        } else {
            return "redirect:/admin/user?message=Ban khong the xoa lich chieu phim.";
        }
    }
}
