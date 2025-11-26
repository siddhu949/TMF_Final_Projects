import React from "react";

export const Footer = () => {
  return (
    <footer
      style={{
        position: "fixed", // fixed at bottom
        bottom: 0,
        left: 0,
        width: "100%",
        backgroundColor: "#fafafa", // light background like Swiggy
        borderTop: "1px solid #e0e0e0",
        padding: "20px 40px",
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        boxShadow: "0 -2px 5px rgba(0,0,0,0.05)",
        zIndex: 100,
        fontFamily: "'Roboto', sans-serif",
      }}
    >
      {/* Left Section */}
      <div style={{ display: "flex", flexDirection: "column" }}>
        <span style={{ fontWeight: "bold", fontSize: "18px", color: "#fc8019" }}>
          SwiggyApp
        </span>
        <span style={{ fontSize: "14px", color: "#555" }}>© 2025 FoodieApp Pvt Ltd</span>
      </div>

      {/* Center Links */}
      <div style={{ display: "flex", gap: "20px", fontSize: "14px", color: "#555" }}>
        <a href="#" style={{ textDecoration: "none", color: "#555" }}>
          About
        </a>
        <a href="#" style={{ textDecoration: "none", color: "#555" }}>
          Careers
        </a>
        <a href="#" style={{ textDecoration: "none", color: "#555" }}>
          Help
        </a>
        <a href="#" style={{ textDecoration: "none", color: "#555" }}>
          Terms
        </a>
      </div>

      {/* Right Social Icons */}
      <div style={{ display: "flex", gap: "15px" }}>
        <a href="#" style={{ color: "#555" }}>FB</a>
        <a href="#" style={{ color: "#555" }}>TW</a>
        <a href="#" style={{ color: "#555" }}>IG</a>
      </div>
    </footer>
  );
};


