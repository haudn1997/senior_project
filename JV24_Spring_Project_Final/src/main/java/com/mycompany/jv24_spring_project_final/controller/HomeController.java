package com.mycompany.jv24_spring_project_final.controller;

import com.mycompany.jv24_spring_project_final.codeQR.CodeQR;
import com.mycompany.jv24_spring_project_final.entities.BookChairEntity;
import com.mycompany.jv24_spring_project_final.entities.BookTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.CategoryTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.ComboDetailEntity;
import com.mycompany.jv24_spring_project_final.entities.ComboEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieEntity;
import com.mycompany.jv24_spring_project_final.entities.MovieScheduleEntity;
import com.mycompany.jv24_spring_project_final.entities.PositionSeatEntity;
import com.mycompany.jv24_spring_project_final.entities.RoomEntity;
import com.mycompany.jv24_spring_project_final.entities.SeatLineEntity;
import com.mycompany.jv24_spring_project_final.entities.TicketDetailEntity;
import com.mycompany.jv24_spring_project_final.entities.UserEntity;
import com.mycompany.jv24_spring_project_final.service.BookChairService;
import com.mycompany.jv24_spring_project_final.service.BookTicketService;
import com.mycompany.jv24_spring_project_final.service.CategoryTicketService;
import com.mycompany.jv24_spring_project_final.service.ComboDetailService;
import com.mycompany.jv24_spring_project_final.service.ComboService;
import com.mycompany.jv24_spring_project_final.service.MovieScheduleService;
import com.mycompany.jv24_spring_project_final.service.MovieService;
import com.mycompany.jv24_spring_project_final.service.PositionSeatService;
import com.mycompany.jv24_spring_project_final.service.RoomService;
import com.mycompany.jv24_spring_project_final.service.SeatLineService;
import com.mycompany.jv24_spring_project_final.service.TicketDetailService;
import com.mycompany.jv24_spring_project_final.service.UserService;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.SimpleFormatter;
import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.PageRequest;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

    @Autowired
    private MovieService movieService;

    @Autowired
    private RoomService roomService;

    @Autowired
    private MovieScheduleService movieScheduleService;

    @Autowired
    private CategoryTicketService categoryTicketService;

    @Autowired
    private ComboService comboService;

    @Autowired
    private PositionSeatService positionSeatService;

    @Autowired
    private SeatLineService seatLineService;

    @Autowired
    private BookTicketService bookTicketService;

    @Autowired
    private TicketDetailService ticketDetailService;

    @Autowired
    private ComboDetailService comboDetailService;

    @Autowired
    private BookChairService bookChairService;
    
    @Autowired
    private UserService userService;

    @Autowired
    private JavaMailSender mailSender;

    @RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public String home(Model model) {
        return "redirect-page";
    }

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public String home1(Model model, @RequestParam(value = "page", defaultValue = "1", required = false) int page) {
        model.addAttribute("lstMovies", movieService.findAll(new PageRequest(page - 1, 6)));
        model.addAttribute("page", page);
        return "home";
    }

    @RequestMapping(value = "showing")
    public String showingMovie(Model model) {
        LocalDate date = LocalDate.now();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        String currentDateString = dtf.format(date);
        model.addAttribute("lstShowing", movieService.findDate(currentDateString));
        return "showing-movie";
    }

    @RequestMapping(value = "coming")
    public String comingMovie(Model model) {
        LocalDate date = LocalDate.now();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        String currentDateString = dtf.format(date);
        model.addAttribute("lstComing", movieService.findDateComing(currentDateString));
        return "coming-movie";
    }

    @RequestMapping(value = "/showdetail/{id}")
    public String showDetail(Model model, @PathVariable(value = "id") int id) {
        MovieEntity m = movieService.findById(id);
        if (m.getId() > 0) {
            model.addAttribute("movie", movieService.findById(id));
            model.addAttribute("minutes", (m.getTime().getHours() * 60) + m.getTime().getMinutes());
        }

        return "movie-detail";
    }

    @RequestMapping(value = "/watch-trailer/{id}")
    public String watchTrailer(Model model, @PathVariable(value = "id") int id) {
        model.addAttribute("m", movieService.findById(id));
        return "watch-trailer";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public String search(Model model, @ModelAttribute(value = "searchText") String searchText, @RequestParam(value = "page", defaultValue = "1", required = false) int page) {
        model.addAttribute("lstMovies", movieService.findByName(searchText, new PageRequest(page - 1, 6)));
        model.addAttribute("page", page);
        return "home";
    }

    @RequestMapping(value = "/searchFilm", method = RequestMethod.POST)
    public String searchFilm(Model model, @ModelAttribute(value = "filmId") int filmId,
            @ModelAttribute(value = "roomId") int roomId,
            @ModelAttribute(value = "date") String date) throws ParseException {

        SimpleDateFormat dtf2 = new SimpleDateFormat("yyyy-MM-dd");
        Date date1 = new Date();
        String currentDateString = dtf2.format(date1);
        Date dateSearch = dtf2.parse(currentDateString);
        Date dateSearchFirm = dtf2.parse(date);
        List<MovieScheduleEntity> lstMovieSchedules = movieScheduleService.findDate(new MovieEntity(filmId), new RoomEntity(roomId), dateSearchFirm);

        if (lstMovieSchedules.size() > 0) {
            model.addAttribute("lstDateTime", lstMovieSchedules);
            model.addAttribute("movie", movieService.findById(filmId));
            MovieEntity m = movieService.findById(filmId);
            if (m.getId() > 0) {
                model.addAttribute("minutes", (m.getTime().getHours() * 60) + m.getTime().getMinutes());
            }
            model.addAttribute("action", "dateTime");
        } else {
            model.addAttribute("action", "bookTicket");
            model.addAttribute("messages", true);
        }

        model.addAttribute("date", date);
        model.addAttribute("lstMovie", movieService.findAll());
        model.addAttribute("lstRoom", roomService.findAll());
        return "book-ticket";
    }

    @RequestMapping(value = {"contact"}, method = RequestMethod.GET)
    public String contact(Model model) {
        return "contact";
    }

    @RequestMapping(value = {"book-ticket"}, method = RequestMethod.GET)
    public String bookTicket(Model model) {
        LocalDate date = LocalDate.now();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String currentDateString = dtf.format(date);
        model.addAttribute("date", currentDateString);
        model.addAttribute("lstMovie", movieService.findDate(currentDateString));
        model.addAttribute("lstRoom", roomService.findAll());
        model.addAttribute("action", "bookTicket");
        return "book-ticket";
    }

    @RequestMapping(value = {"book-ticket-film/{id}"}, method = RequestMethod.GET)
    public String bookTicketFilm(Model model, @PathVariable(value = "id") int id) {
        LocalDate date = LocalDate.now();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String currentDateString = dtf.format(date);
        model.addAttribute("date", currentDateString);
        model.addAttribute("lstMovie", movieService.findAll());
        model.addAttribute("lstRoom", roomService.findAll());
        model.addAttribute("movie", movieService.findById(id));
        MovieEntity m = movieService.findById(id);
        if (m.getId() > 0) {
            model.addAttribute("minutes", (m.getTime().getHours() * 60) + m.getTime().getMinutes());
        }
        model.addAttribute("action", "filmDetail");
        return "book-ticket";
    }

    @RequestMapping(value = "choose-ticket/{id}", method = RequestMethod.GET)
    public String chooseTicket(Model model, @PathVariable(value = "id") int id,
            HttpSession session, @RequestParam(value = "message", required = false) String message) {
        MovieScheduleEntity mv = movieScheduleService.findById(id);
        BookTicketEntity bookSession = (BookTicketEntity) session.getAttribute("bookTicket");
        bookSession = new BookTicketEntity();
        bookSession.setMovie(mv.getMovie());
        bookSession.setMovieScheduleEntity(mv); // save schedule movies
        session.setAttribute("bookTicket", bookSession);
        session.setAttribute("numberChair", 0);
        model.addAttribute("movieSchedule", movieScheduleService.findById(id));
        model.addAttribute("lstCategory", categoryTicketService.findAll());
        model.addAttribute("lstCombo", comboService.findAll());
        model.addAttribute("movieScheduleId", id);
        model.addAttribute("message", message);
        return "choose-ticket";
    }

    // send movie Id, 
    @RequestMapping(value = "/choose-seat/{id}/{movieId}/{scheduleId}", method = RequestMethod.GET)
    public String chooseSeat(Model model, @PathVariable(value = "id") int id, HttpSession session, @RequestParam(value = "message", required = false) String message,
            @PathVariable(value = "movieId") int movieId, @PathVariable(value = "scheduleId") int scheduleId) {
        BookTicketEntity bookSession = (BookTicketEntity) session.getAttribute("bookTicket");
        int numberChair = (int) session.getAttribute("numberChair");
        if (bookSession.getTotalPrice() > 0) {
            if (numberChair > 0) {
                List<SeatLineEntity> lstSeat = seatLineService.findByRoom(new RoomEntity(id));
                Map<String, List<PositionSeatEntity>> positionMap = new HashMap<String, List<PositionSeatEntity>>();
                for (SeatLineEntity s : lstSeat) {
                    positionMap.put(s.getName(), s.getPositionSeat());

                }
                List<BookTicketEntity> lstBookTicket = bookTicketService.findBookTicketByMovieIdAndScheduleId(movieId, scheduleId);
                Map<Integer, List<BookChairEntity>> lstBookChair = new HashMap<Integer, List<BookChairEntity>>();
                for (BookTicketEntity b : lstBookTicket) {
                    lstBookChair.put(b.getId(), bookChairService.findByBookTicket(new BookTicketEntity(b.getId())));
                }
                model.addAttribute("lstPosition", positionMap);
                model.addAttribute("message", message);
                model.addAttribute("roomId", id);
                model.addAttribute("movieId", movieId);
                model.addAttribute("scheduleId", scheduleId);
                MovieScheduleEntity mv = movieScheduleService.findById(scheduleId);
                model.addAttribute("movieSchedule", mv);
                model.addAttribute("lstSeatSelected", lstBookChair);
                model.addAttribute("lstBookChair", bookSession.getBookChair());
                return "choose-seat";
            } else {
                return "redirect:/choose-ticket/" + id + "?message=Xin quy khach vui long chon so luong ve!";
            }
        } else {
            return "redirect:/choose-ticket/" + id + "?message=Xin quy khach vui long chon so luong ve!";
        }

    }

    @RequestMapping(value = "/update-ticket/{id}", method = RequestMethod.POST)
    public String updateTicket(Model model, @ModelAttribute(value = "quantity") int quantity,
            @ModelAttribute(value = "ticketId") int ticketId, HttpSession session,
            @PathVariable(value = "id") int id) {
        BookTicketEntity bookSession = (BookTicketEntity) session.getAttribute("bookTicket");
        int numberChair = 0;
        if (bookSession != null) {
            List<TicketDetailEntity> lstDetailEntitys = new ArrayList<>();
            double totalPrice = 0;
            if (bookSession.getTicketDetail() != null && bookSession.getTicketDetail().size() > 0) {
                lstDetailEntitys = bookSession.getTicketDetail();
            }
            CategoryTicketEntity ticketEntity = categoryTicketService.findTicketCategoryById(ticketId);
            if (ticketEntity != null && ticketEntity.getId() > 0) {
                if (lstDetailEntitys.size() > 0) {
                    for (int i = 0; i < lstDetailEntitys.size(); i++) {
                        if (lstDetailEntitys.get(i).getCategoryTicket().getId() == ticketEntity.getId()) {
                            lstDetailEntitys.remove(i);
                            break;
                        }
                    }
                }
                TicketDetailEntity detailEntity = new TicketDetailEntity();
                detailEntity.setCategoryTicket(ticketEntity);
                detailEntity.setQuantity(quantity);
                lstDetailEntitys.add(detailEntity);
                bookSession.setTicketDetail(lstDetailEntitys);
            }
            if (lstDetailEntitys.size() > 0) {
                for (TicketDetailEntity detailEntity : lstDetailEntitys) {
                    totalPrice = totalPrice + (detailEntity.getQuantity() * detailEntity.getCategoryTicket().getPrice());
                    numberChair = numberChair + detailEntity.getQuantity();
                }
                bookSession.setTotalPrice(totalPrice);
            }

        }
        session.setAttribute("bookTicket", bookSession);
        session.setAttribute("numberChair", numberChair);
        model.addAttribute("bookTicketSelected", bookSession.getTicketDetail());
        model.addAttribute("movieSchedule", movieScheduleService.findById(id));
        model.addAttribute("lstCategory", categoryTicketService.findAll());
        model.addAttribute("lstCombo", comboService.findAll());
        model.addAttribute("movieScheduleId", id);
        model.addAttribute("bookSession", bookSession);
        model.addAttribute("bookComboSelected", bookSession.getComboDetail());
        return "choose-ticket";
    }

    @RequestMapping(value = "/update-combo/{id}", method = RequestMethod.POST)
    public String updateCombo(Model model, @ModelAttribute(value = "quantity") int quantity,
            @ModelAttribute(value = "comboId") int comboId, HttpSession session,
            @PathVariable(value = "id") int id) {
        BookTicketEntity bookSession = (BookTicketEntity) session.getAttribute("bookTicket");
        if (bookSession != null) {
            List<ComboDetailEntity> lstComboDetail = new ArrayList<>();
            double totalPrice = 0;
            if (bookSession.getComboDetail() != null && bookSession.getComboDetail().size() > 0) {
                lstComboDetail = bookSession.getComboDetail();
            }
            ComboEntity combo = comboService.findComboId(comboId);
            if (combo != null && combo.getId() > 0) {
                if (lstComboDetail.size() > 0) {
                    for (int i = 0; i < lstComboDetail.size(); i++) {
                        if (lstComboDetail.get(i).getCombo().getId() == combo.getId()) {
                            lstComboDetail.remove(i);
                            break;
                        }
                    }
                }
                ComboDetailEntity comboDetail = new ComboDetailEntity();
                comboDetail.setCombo(combo);
                comboDetail.setQuantity(quantity);
                lstComboDetail.add(comboDetail);
                bookSession.setComboDetail(lstComboDetail);
            }
            if (lstComboDetail.size() > 0) {
                for (ComboDetailEntity comboDetail : lstComboDetail) {
                    totalPrice = totalPrice + bookSession.getTotalPrice() + (comboDetail.getQuantity() * comboDetail.getCombo().getPrice());
                }
                bookSession.setTotalPrice(totalPrice);
            }

        }
        session.setAttribute("bookTicket", bookSession);
        model.addAttribute("bookComboSelected", bookSession.getComboDetail());
        model.addAttribute("movieSchedule", movieScheduleService.findById(id));
        model.addAttribute("lstCategory", categoryTicketService.findAll());
        model.addAttribute("lstCombo", comboService.findAll());
        model.addAttribute("movieScheduleId", id);
        model.addAttribute("bookSession", bookSession);
        model.addAttribute("bookTicketSelected", bookSession.getTicketDetail());
        return "choose-ticket";
    }

    @RequestMapping(value = "/book-seat/{id}/{movieId}/{scheduleId}", method = RequestMethod.POST)
    public String bookSeat(Model model, @ModelAttribute(value = "positionId") int positionId, HttpSession session,
            @PathVariable(value = "id") int id, @PathVariable(value = "movieId") int movieId, @PathVariable(value = "scheduleId") int scheduleId) {
        List<SeatLineEntity> lstSeat = seatLineService.findByRoom(new RoomEntity(id));
        Map<String, List<PositionSeatEntity>> positionMap = new HashMap<String, List<PositionSeatEntity>>();
        for (SeatLineEntity s : lstSeat) {
            positionMap.put(s.getName(), s.getPositionSeat());

        }

        BookTicketEntity bookSession = (BookTicketEntity) session.getAttribute("bookTicket");
        int numberChair = (int) session.getAttribute("numberChair");
        if (bookSession != null) {
            List<BookChairEntity> lstBookChair = new ArrayList<>();
            if (bookSession.getBookChair() != null && bookSession.getBookChair().size() > 0) {
                lstBookChair = bookSession.getBookChair();
            }
            PositionSeatEntity position = positionSeatService.findById(positionId);

            if (position != null && position.getId() > 0) {
                boolean isExist = false;
                if (lstBookChair.size() > 0) {
                    for (int i = 0; i < lstBookChair.size(); i++) {
                        if (lstBookChair.get(i).getPositionSeat().getId() == position.getId()) {
                            isExist = true;
                            break;
                        }
                    }
                    if (!isExist && numberChair > 0 && numberChair == lstBookChair.size()) {
                        lstBookChair.remove(0);
                    }

                }
                if (!isExist) {
                    BookChairEntity bookChair = new BookChairEntity();
                    bookChair.setPositionSeat(position);
                    lstBookChair.add(bookChair);
                    bookSession.setBookChair(lstBookChair);
                }
            }
            model.addAttribute("lstBookChair", bookSession.getBookChair());
        }
        session.setAttribute("bookTicket", bookSession);
        session.setAttribute("numberChair", numberChair);
        List<BookTicketEntity> lstBookTicket = bookTicketService.findBookTicketByMovieIdAndScheduleId(movieId, scheduleId);
        Map<Integer, List<BookChairEntity>> lstBookChair = new HashMap<Integer, List<BookChairEntity>>();
        for (BookTicketEntity b : lstBookTicket) {
            lstBookChair.put(b.getId(), bookChairService.findByBookTicket(new BookTicketEntity(b.getId())));
        }
        model.addAttribute("roomId", id);
        model.addAttribute("movieId", movieId);
        model.addAttribute("scheduleId", scheduleId);
        MovieScheduleEntity mv = movieScheduleService.findById(scheduleId);
        model.addAttribute("movieSchedule", mv);
        model.addAttribute("lstPosition", positionMap);
        model.addAttribute("lstSeatSelected", lstBookChair);
        return "choose-seat";
    }

    @RequestMapping(value = "check-out-info", method = RequestMethod.GET)
    public String checkoutInfo(Model model, HttpSession session, Principal a) {
        BookTicketEntity bookSession = (BookTicketEntity) session.getAttribute("bookTicket");

        if (bookSession != null) {
            int numberChair = (int) session.getAttribute("numberChair");
            if (bookSession.getBookChair() != null) {
                if (bookSession.getBookChair().size() == numberChair) {
                    if (a == null) {
                        return "login";
                    } else {
                        if (bookSession != null) {
                            model.addAttribute("total", bookSession.getTotalPrice());
                            return "check-info";
                        } else {
                            return "redirect:/book-ticket";
                        }
                    }
                } else {
                    return "redirect:/choose-seat/" + bookSession.getMovieScheduleEntity().getRoom().getId() + "/"
                            + bookSession.getMovieScheduleEntity().getMovie().getId() + "/"
                            + bookSession.getMovieScheduleEntity().getId()
                            + "?message=Số luong ghe ban chon khong du so voi so luong ve ban mua. Xin quy khach vui long chon lai!";
                }

            } else {
                return "redirect:/choose-seat/" + bookSession.getMovieScheduleEntity().getRoom().getId() + "/"
                        + bookSession.getMovieScheduleEntity().getMovie().getId() + "/"
                        + bookSession.getMovieScheduleEntity().getId()
                        + "?message=Số luong ghe ban chon khong du so voi so luong ve ban mua. Xin quy khach vui long chon lai!";
            }
        } else {
            return "redirect:/book-ticket";
        }

    }
       
    @RequestMapping(value = "one-pay", method = RequestMethod.POST)
    public void onepay(Model model, HttpServletRequest request, HttpServletResponse response, 
            @ModelAttribute(value = "userId") int userId, @ModelAttribute(value = "email") String email, HttpSession session) throws IOException {
        Map fields = new HashMap();
        for (Enumeration enum1 = request.getParameterNames(); enum1.hasMoreElements();) {
            String fieldName = (String) enum1.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }
        String vpcURL = (String) fields.remove("virtualPaymentClientURL");
        fields.remove("SubButL");
        String againLink = request.getHeader("Referer");
        fields.put("AgainLink", againLink);
        if (SECURE_SECRET != null && SECURE_SECRET.length() > 0) {
            String secureHash = hashAllFields(fields);
            fields.put("vpc_SecureHash", secureHash);
        }
        StringBuffer buf = new StringBuffer();
        buf.append(vpcURL).append('?');
        appendQueryFields(buf, fields);
        System.out.println(buf.toString());
        response.sendRedirect(buf.toString());
        
        BookTicketEntity bookSession = (BookTicketEntity) session.getAttribute("bookTicket");
        if (bookSession != null) {
            BookTicketEntity bookTicket = new BookTicketEntity();
            bookTicket.setCreateAt(new Date());
            bookTicket.setTotalPrice(bookSession.getTotalPrice());
            bookTicket.setMovieScheduleEntity(new MovieScheduleEntity(bookSession.getMovieScheduleEntity().getId()));
            bookTicket.setMovie(new MovieEntity(bookSession.getMovie().getId()));
            bookTicket.setUser(new UserEntity(userId));

            int bookTicketId = bookTicketService.save(bookTicket).getId();

            int totalQuantity = 0;
            
            int totalQuantityCombo = 0;

            MovieScheduleEntity mv = movieScheduleService.findById(bookSession.getMovieScheduleEntity().getId());

            MovieEntity m = movieService.findById(bookSession.getMovie().getId());
            
            UserEntity user = userService.findByIdUser(userId);

            for (int i = 0; i < bookSession.getTicketDetail().size(); i++) {
                if (bookSession.getTicketDetail().get(i).getQuantity() > 0) {
                    totalQuantity = totalQuantity + bookSession.getTicketDetail().get(i).getQuantity();
                    TicketDetailEntity t = new TicketDetailEntity();
                    t.setCategoryTicket(new CategoryTicketEntity(bookSession.getTicketDetail().get(i).getCategoryTicket().getId()));
                    t.setQuantity(bookSession.getTicketDetail().get(i).getQuantity());
                    t.setBookTicket(new BookTicketEntity(bookTicketId));
                    ticketDetailService.save(t);
                }
            }
            if (bookSession.getComboDetail() != null) {
                for (int j = 0; j < bookSession.getComboDetail().size(); j++) {
                    totalQuantityCombo = totalQuantityCombo + bookSession.getComboDetail().get(j).getQuantity();
                    ComboDetailEntity c = new ComboDetailEntity();
                    c.setCombo(new ComboEntity(bookSession.getComboDetail().get(j).getCombo().getId()));
                    c.setBookTicket(new BookTicketEntity(bookTicketId));
                    c.setQuantity(bookSession.getComboDetail().get(j).getQuantity());
                    comboDetailService.save(c);
                }
            }

            if (bookSession.getBookChair() != null) {
                for (int f = 0; f < bookSession.getBookChair().size(); f++) {
                    BookChairEntity b = new BookChairEntity();
                    b.setPositionSeat(new PositionSeatEntity(bookSession.getBookChair().get(f).getPositionSeat().getId()));
                    b.setBookTicket(new BookTicketEntity(bookTicketId));
                    bookChairService.save(b);
                }
            }

            try {

                MimeMessage message = mailSender.createMimeMessage();

                String from = "ecommercesystem@email.com";
                String recipientAddress = email;
                String subject = "Your Order";
                String msg = "<h2>Thông tin đặt vé của bạn</h2>"
                        + "<table border='1'><tr><th>Tên Phim</th><th>Ngày Chiếu</th><th>Giờ chiếu</th><th>Phòng</th><th>Số lượng vế</th><th>Số lượng combo</th><th>Code QR</th></tr>"
                        + "<tr>"
                        + "<td>" + m.getName() + "</td>"
                        + "<td>" + mv.getDate() + "</td>"
                        + "<td>" + mv.getTime() + "</td>"
                        + "<td>" + mv.getRoom().getName() + "</td>"
                        + "<td>" + totalQuantity + "</td>"
                        + "<td>" + totalQuantityCombo + "</td>"
                        + "<td>" + "<img src='http://localhost:8084/JV24_Spring_Project_Final/qrcode/" + user.getFullName() + "' width='100' height='100' />" + "</td>"
                        + "</tr>"
                        + "<tr><td colspan='7'>Tổng tiền</td><td>" + bookTicket.getTotalPrice() + "</td></tr></table>";

                message.setSubject(subject);
                MimeMessageHelper helper;
                helper = new MimeMessageHelper(message, true, "utf-8");
                helper.setFrom(from);
                helper.setTo(recipientAddress);
                helper.setText(msg, true);
                mailSender.send(message);

            } catch (MessagingException ex) {
                model.addAttribute("message", "Send email error! " + ex.toString() + ".");
            }

        }
    }

    @RequestMapping(value = "payment-success", method = RequestMethod.GET)
    public String paymentSuccess(Model model, HttpSession session) {
        session.removeAttribute("bookTicket");
        return "check-out";
    }
    
    @RequestMapping(value = "qrcode/{id}", method = RequestMethod.GET)
    public void qrcode(@PathVariable("id") String id, HttpServletResponse response) throws Exception {
        response.setContentType("image/png");
        OutputStream outputStream = response.getOutputStream();
        outputStream.write(CodeQR.getQRCodeImage(id, 200, 200));
        outputStream.flush();
        outputStream.close();
    }

    static final String SECURE_SECRET = "A3EFDFABA8653DF2342E8DAC29B51AF0";
    static final char[] HEX_TABLE = new char[]{
        '0', '1', '2', '3', '4', '5', '6', '7',
        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    private static byte[] decodeHexArray = new byte[103];

    static {
        int i = 0;
        for (byte b : new byte[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'}) {
            decodeHexArray[b] = (byte) i++;
        }
        decodeHexArray['a'] = decodeHexArray['A'];
        decodeHexArray['b'] = decodeHexArray['B'];
        decodeHexArray['c'] = decodeHexArray['C'];
        decodeHexArray['d'] = decodeHexArray['D'];
        decodeHexArray['e'] = decodeHexArray['E'];
        decodeHexArray['f'] = decodeHexArray['F'];
    }

    String hashAllFields(Map fields) {
        List fieldNames = new ArrayList(fields.keySet());
        Collections.sort(fieldNames);
        StringBuffer buf = new StringBuffer();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0) && fieldName.indexOf("vpc_") == 0) {
                buf.append(fieldName + "=" + fieldValue);
                if (itr.hasNext()) {
                    buf.append('&');
                }
            }
        }
        byte[] mac = null;
        try {
            byte[] b = decodeHexa(SECURE_SECRET.getBytes());
            SecretKey key = new SecretKeySpec(b, "HMACSHA256");
            Mac m = Mac.getInstance("HMACSHA256");
            m.init(key);
            m.update(buf.toString().getBytes("UTF-8"));
            mac = m.doFinal();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String hashValue = hex(mac);
        return hashValue;
    }

    public static byte[] decodeHexa(byte[] data) throws Exception {
        if (data == null) {
            return null;
        }
        if (data.length % 2 != 0) {
            throw new Exception("Invalid data length:" + data.length);
        }
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        byte b1, b2;
        int i = 0;
        while (i < data.length) {
            b1 = decodeHexArray[data[i++]];
            b2 = decodeHexArray[data[i++]];
            out.write((b1 << 4) | b2);
        }
        out.flush();
        out.close();
        return out.toByteArray();
    }

    static String hex(byte[] input) {
        StringBuffer sb = new StringBuffer(input.length * 2);
        for (int i = 0; i < input.length; i++) {
            sb.append(HEX_TABLE[(input[i] >> 4) & 0xf]);
            sb.append(HEX_TABLE[input[i] & 0xf]);
        }
        return sb.toString();
    }

    void appendQueryFields(StringBuffer buf, Map fields) {
        List fieldNames = new ArrayList(fields.keySet());
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) fields.get(fieldName);

            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                buf.append(URLEncoder.encode(fieldName));
                buf.append('=');
                buf.append(URLEncoder.encode(fieldValue));
            }
            if (itr.hasNext()) {
                buf.append('&');
            }

        }
    }

    String getResponseDescription(String vResponseCode) {
        Map<String, String> map_result = new HashMap<String, String>() {
            {
                put("0", "Giao dịch thành công");
                put("1", "Ngân hàng từ chối giao dịch");
                put("3", "Mã đơn vị không tồn tại");
                put("4", "Không đúng access code");
                put("5", "Số tiền không hợp lệ");
                put("6", "Mã tiền tệ không tồn tại");
                put("7", "Lỗi không xác định");
                put("8", "Số thẻ không đúng");
                put("9", "Tên chủ thẻ không đúng");
                put("10", "Thẻ hết hạn/Thẻ bị khóa");
                put("11", "Thẻ chưa đăng ký sử dụng dịch vụ");
                put("12", "Ngày phát hành/Hết hạn không đúng");
                put("13", "Vượt quá hạn mức thanh toán");
                put("21", "Số tiền không đủ để thanh toán");
                put("99", "Người sủ dụng hủy giao dịch");
            }
        };
        String result = "";
        result = map_result.get(vResponseCode);
        if (result != null) {
            return result;
        } else {
            return "No Value Returned";
        }
    }

    private static String null2unknown(String in) {
        if (in == null || in.length() == 0) {
            return "No Value Returned";
        } else {
            return in;
        }
    }
}
