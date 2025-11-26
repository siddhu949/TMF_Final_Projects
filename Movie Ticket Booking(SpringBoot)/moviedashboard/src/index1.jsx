import React, { useEffect, useState } from "react";
import { createRoot } from "react-dom/client";

const API_URL = "http://localhost:8080/api/movies";

function App() {
  const [movies, setMovies] = useState([]);
  const [pageNumber, setPageNumber] = useState(0);
  const pageSize = 5;

  const [totalPages, setTotalPages] = useState(0);
  const [sortField, setSortField] = useState("");

  const loadMovies = () => {
    const url =
      sortField === ""
        ? `${API_URL}/pagination/${pageNumber}/${pageSize}`
        : `${API_URL}/sort/${sortField}`;

    fetch(url)
      .then((res) => res.json())
      .then((data) => {
        if (Array.isArray(data)) {
          setMovies(data); // Sorting returns full list
          setTotalPages(1);
        } else {
          setMovies(data.content || []);
          setTotalPages(data.totalPages || 0);
        }
      })
      .catch((err) => console.error(err));
  };

  useEffect(() => {
    loadMovies();
  }, [pageNumber, sortField]);

  return (
    <div style={{ padding: "20px" }}>
      <h2>Movie Dashboard</h2>

      {/* Sort Dropdown */}
      <div style={{ marginBottom: "10px" }}>
        <label><b>Sort By:</b> </label>
        <select
          value={sortField}
          onChange={(e) => {
            setSortField(e.target.value);
            setPageNumber(0); // reset pagination
          }}
          style={{ marginLeft: "10px", padding: "5px" }}
        >
          <option value="">(Default) Pagination</option>
          <option value="title">Title</option>
          <option value="language">Language</option>
          <option value="description">Description</option>
        </select>
      </div>

      {/* Movie Table */}
      <table border="1" width="100%" cellPadding="8">
        <thead>
          <tr>
            <th>Title</th>
            <th>Language</th>
            <th>Description</th>
          </tr>
        </thead>

        <tbody>
          {movies.map((m) => (
            <tr key={m.id}>
              <td>{m.title}</td>
              <td>{m.language}</td>
              <td>{m.description}</td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* Pagination */}
      {sortField === "" && (
        <div style={{ textAlign: "center", marginTop: "15px" }}>
          <button
            onClick={() => setPageNumber((p) => Math.max(p - 1, 0))}
            disabled={pageNumber === 0}
          >
            ⬅ Previous
          </button>

          {/* Page Numbers */}
          {Array.from({ length: totalPages }, (_, i) => (
            <button
              key={i}
              onClick={() => setPageNumber(i)}
              style={{
                margin: "0 5px",
                background: pageNumber === i ? "#ddd" : "white",
              }}
            >
              {i + 1}
            </button>
          ))}

          <button
            onClick={() =>
              setPageNumber((p) => (p + 1 < totalPages ? p + 1 : p))
            }
            disabled={pageNumber + 1 >= totalPages}
          >
            Next ➡
          </button>
        </div>
      )}
    </div>
  );
}

const root = createRoot(document.getElementById("root"));
root.render(<App />);