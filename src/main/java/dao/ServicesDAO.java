/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dao;

import db.ConnectData;
import java.sql.Connection;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class ServicesDAO {
    private Connection conn = null;

    public ServicesDAO() {
        conn = ConnectData.getConnection();
    }

    
    
}
