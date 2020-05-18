package com.jaraxa.app.core.utils;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.CellStyle;

public class ExportCsvUtils {
	
    public static void setCellValue(HSSFSheet sheet, int rowIndex, int columnIndex, String value) {
        HSSFRow row = (sheet.getRow(rowIndex) == null) ? sheet.createRow((short)rowIndex) : sheet.getRow(rowIndex);
        HSSFCell cell = (row.getCell(columnIndex) == null) ? row.createCell(columnIndex) : row.getCell(columnIndex);
        cell.setCellValue(value);  
    }
    
    public static void setCellValue(HSSFSheet sheet, int rowIndex, int columnIndex, int value) {
        HSSFRow row = (sheet.getRow(rowIndex) == null) ? sheet.createRow((short)rowIndex) : sheet.getRow(rowIndex);
        HSSFCell cell = (row.getCell(columnIndex) == null) ? row.createCell(columnIndex) : row.getCell(columnIndex);
        cell.setCellValue(value);  
    }
    
    public static void setCellStyle(HSSFSheet sheet, int rowIndex, int columnIndex, CellStyle cellStyle) {
        HSSFRow row = sheet.getRow(rowIndex);
        HSSFCell cell = row.getCell(columnIndex);
        cell.setCellStyle(cellStyle);  
    }
	

}
