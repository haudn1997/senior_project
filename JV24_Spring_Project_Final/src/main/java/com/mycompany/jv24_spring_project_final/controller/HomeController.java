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
import java.io.File;
import java.io.OutputStream;
import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.SimpleFormatter;
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
                return "redirect:/choose-ticket/" + id + "?message=Please type number tickets!!!";
            }
        } else {
            return "redirect:/choose-ticket/" + id + "?message=Xin quy khach vui long chon so luong ve!!!";
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
                            return "check-info";
                        } else {
                            return "redirect:/book-ticket";
                        }
                    }
                } else {
                    return "redirect:/choose-seat/" + bookSession.getMovieScheduleEntity().getRoom().getId() + "/"
                            + bookSession.getMovieScheduleEntity().getMovie().getId() + "/"
                            + bookSession.getMovieScheduleEntity().getId()
                            + "?message=So luong ghe ban chon khong du so voi so luonng ve ban mua. Xin quy khach vui long chon lai!";
                }

            } else {
                return "redirect:/choose-seat/" + bookSession.getMovieScheduleEntity().getRoom().getId() + "/"
                        + bookSession.getMovieScheduleEntity().getMovie().getId() + "/"
                        + bookSession.getMovieScheduleEntity().getId()
                        + "?message=So luong ghe ban chon khong du so voi so luonng ve ban mua. Xin quy khach vui long chon lai!";
            }
        } else {
            return "redirect:/book-ticket";
        }

    }

    @RequestMapping(value = "check-out", method = RequestMethod.POST)
    public String checkout(Model model, HttpSession session, @ModelAttribute(value = "userId") int userId,
            @ModelAttribute(value = "email") String email) {

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

//                String from = "ecommercesystem@email.com";
                String recipientAddress = email;
                String subject = "Your Order";
                String msg = "<h2>Your Order Information</h2>"
                        + "<table border='1'><tr><th>Tên Phim</th><th>Ngày Chiếu</th><th>Gio chieu</th><th>Phong</th><th>So luong ve</th><th>So luong Combo</th><th>Code QR</th></tr>"
                        + "<tr>"
                        + "<td>" + m.getName() + "</td>"
                        + "<td>" + mv.getDate() + "</td>"
                        + "<td>" + mv.getTime() + "</td>"
                        + "<td>" + mv.getRoom().getName() + "</td>"
                        + "<td>" + totalQuantity + "</td>"
                        + "<td>" + totalQuantityCombo + "</td>"
                        + "<td>" + "<img src='http://node194476-cinemaxxi.jelastic.servint.net/home/qrcode/" + m.getName() + "' width='100' height='100' />" + "</td>"
                        + "</tr>"
                        + "<tr><td colspan='7'>Tong tien</td><td>" + bookTicket.getTotalPrice() + "</td></tr></table>";

                MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
                message.setContent(msg, "text/html");
                helper.setTo(recipientAddress);
                helper.setSubject(subject);
//                helper.setFrom(from);                
//                helper.setText(msg, true);
                mailSender.send(message);

            } catch (MessagingException ex) {
                model.addAttribute("message", "Send email error! " + ex.toString() + ".");
                return "checkout";
            }

        }
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

}
