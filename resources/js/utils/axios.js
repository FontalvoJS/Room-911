import axios from "axios";
const token = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");
const axios_instance = axios.create({
    baseURL: import.meta.env.VITE_API_URL,
    headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
        "X-CSRF-TOKEN": token,
    },
});

export default axios_instance;
