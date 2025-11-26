import { useState,useEffect } from "react"
import React from 'react'
const userDetails="https://jsonplaceholder.typicode.com/posts";
    console.log(userDetails);
const UserPage = () => {
    const [user,setUser]=useState([])
    const userHandler=async()=>{
        const response=await fetch(userDetails);
        const newData=await response.json();
        setUser(newData)
    }
    useEffect(()=>{
      console.log(userHandler());
    },[])
    console.log(user);
  return <div>
    {
      user.map((item,index)=>{
        return(
          <div className="userSection"key= {item.id} >
            
            
            <h2>{item.title}</h2>
          </div>
        
        )
      })
    }
  </div>
  
};

export default UserPage;
