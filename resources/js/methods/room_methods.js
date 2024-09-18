import "../../css/app.css";
import { useToast } from "vue-toastification";
import "vue-toastification/dist/index.css";
const toast = useToast();
import axios_instance from "../methods/axios";
export const submitForm = async function() {
    toast.info("Logging in to Room 911...", {
        timeout: 3000,
        position: "top-right",
    });
    this.errors = {}; // Reset errors
    if (!this.form.employee_id) {
        this.errors.employee_id = ["This field is required"];
        return;
    }

    try {
        const response = await axios_instance.post(
            "/login-room",
            this.form
        );
        if (response.status === 200) {
            this.form.success = true;
            toast.success("You'll be redirected", {
                timeout: 3000,
                position: "top-right",
            });
            await new Promise((resolve) =>
                setTimeout(() => {
                    window.location.href = "https://www.lifefile.net/";
                    resolve();
                }, 1000)
            );
        }
    } catch (error) {
        if (error.response && error.response.data.errors) {
            this.errors = error.response.data.errors;
        }
        if (error.response.status === 403) {
            toast.error(error.response.data.error, {
                timeout: 3000,
                position: "top-right",
            });
        }
    }
}