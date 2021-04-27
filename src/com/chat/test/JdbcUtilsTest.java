
package com.chat.test;
import com.chat.utils.JdbcUtils;
 
import java.sql.*;
 
 
public class JdbcUtilsTest {
    public static void main(String[] args) {
 
 
        Connection connection = null;
        connection = JdbcUtils.getConnection();//连接数据库
        System.out.println(connection);
        String sql = "select username from xx";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);//创建PreparedStatement动态语句对象
            ResultSet resultSet = preparedStatement.executeQuery();//返回结果集对象ResultSet
            while (resultSet.next()) {//处理返回结果
                System.out.println(resultSet.getString(1));
//                System.out.println(resultSet.getString(2));
//                System.out.println(resultSet.getString(3));
//                System.out.println(resultSet.getString(4));
            }
            preparedStatement.close();//关闭preparedStatement语句对象
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            JdbcUtils.close(connection);//关闭数据库连接
        }
    }
}