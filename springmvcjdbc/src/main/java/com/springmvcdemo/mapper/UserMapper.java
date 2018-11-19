package com.springmvcdemo.mapper;
import  com.springmvcdemo.model.User;
import  org.apache.ibatis.annotations.Param;
import  org.springframework.stereotype.Repository;
import  java.util.List;

//@Repository
public interface UserMapper {
   User findId(@Param("id") int id);
   int deleteById(@Param("userId") int id);

   int insert(User user);

   int update(User user);

   int updateById(@Param("userId") int id);

   List<User> getAll();
}

