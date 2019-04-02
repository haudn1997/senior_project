
package com.mycompany.jv24_spring_project_final.common;

import com.mycompany.jv24_spring_project_final.entities.BookTicketEntity;
import com.mycompany.jv24_spring_project_final.entities.TicketDetailEntity;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelBuilder extends AbstractExcelView {

    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook hssfw,
            HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        List<BookTicketEntity> lstTicket = (List<BookTicketEntity>) model.get("lstTicket");
        // create a new Excel sheet
        HSSFSheet sheet = hssfw.createSheet("Java Books");
        sheet.setDefaultColumnWidth(30);

        // create style for header cells
        CellStyle style = hssfw.createCellStyle();
        Font font = hssfw.createFont();
        font.setFontName("Arial");
        style.setFillForegroundColor(HSSFColor.BLUE.index);
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        font.setBold(true);
        font.setColor(HSSFColor.WHITE.index);
        style.setFont(font);

        // create header row
        HSSFRow header = sheet.createRow(0);
        header.createCell(0).setCellValue("ID");
        header.getCell(0).setCellStyle(style);

        header.createCell(1).setCellValue("Movie");
        header.getCell(1).setCellStyle(style);

        header.createCell(2).setCellValue("Adult Ticket");
        header.getCell(2).setCellStyle(style);

        header.createCell(3).setCellValue("Children Ticket");
        header.getCell(3).setCellStyle(style);

        header.createCell(4).setCellValue("CreateAt");
        header.getCell(4).setCellStyle(style);

        header.createCell(5).setCellValue("Total Price");
        header.getCell(5).setCellStyle(style);

        // create data rows
        int rowCount = 1;
        for (BookTicketEntity ticket : lstTicket) {
            HSSFRow aRow = sheet.createRow(rowCount++);
            aRow.createCell(0).setCellValue(ticket.getId());
            aRow.createCell(1).setCellValue(ticket.getMovie().getName());
            int a = 0;
            int b = 0;
            for (TicketDetailEntity td : ticket.getTicketDetail()) {
                if (td.getCategoryTicket().getName().equals("ADULT")) {
                    a = td.getQuantity();
                } else {
                    b = td.getQuantity();
                }
            }
            aRow.createCell(2).setCellValue(a);
            aRow.createCell(3).setCellValue(b);
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            String dateFormat = formatter.format(ticket.getCreateAt());

            aRow.createCell(4).setCellValue(dateFormat);
            aRow.createCell(5).setCellValue(ticket.getTotalPrice());
        }
    }

}
