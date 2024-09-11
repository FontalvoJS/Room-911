<template>
    <!-- Filter Section -->
    <div class="filter-section">
        <div class="input-group mb-3">
            <input
                type="text"
                class="form-control"
                placeholder="Search by employee ID"
                aria-label="Search by employee ID"
                v-model="filters.employee_id"
                @change="applyFilters"
            />
            <input
                type="text"
                class="form-control"
                placeholder="Search by firstname"
                aria-label="Search by firstname"
                v-model="filters.name"
                @change="applyFilters"
            />
            <input
                type="text"
                class="form-control"
                placeholder="Search by lastname"
                aria-label="Search by lastname"
                v-model="filters.last_name"
                @change="applyFilters"
            />
            <select
                class="form-select"
                v-model="filters.department"
                @change="applyFilters"
            >
                <option value="" selected>Select a department</option>
                <option
                    v-for="department in departments"
                    :key="department.id"
                    :value="department.id"
                >
                    {{ department.name }}
                </option>
            </select>
        </div>

        <div class="row">
            <div class="col-md-4">
                <label for="initial-access-date" class="form-label">
                    Initial access date:
                </label>
                <input
                    @change="searchByDate"
                    type="date"
                    class="form-control"
                    id="initial-access-date"
                    v-model="filters.initialAccessDate"
                />
            </div>
            <div class="col-md-4">
                <label for="final-access-date" class="form-label">
                    Final access date:
                </label>
                <input
                    @change="searchByDate"
                    type="date"
                    class="form-control"
                    id="final-access-date"
                    v-model="filters.finalAccessDate"
                />
            </div>
        </div>
        <div class="row">
            <div class="col-md-3">
                <button class="btn btn-dark mt-2" @click="applyFilters">
                    Filter
                </button>
                <button
                    class="btn btn-dark mt-2"
                    style="margin-left: 5px"
                    @click="clearFilters"
                >
                    Clear
                </button>
            </div>
        </div>
    </div>
</template>
<script>
import { useToast } from "vue-toastification";
import axios_instance from "../utils/axios";
import "vue-toastification/dist/index.css";
const toast = useToast();
export default {
    name: "FilterComponent",
    props: {
        departments: {
            type: Array,
            required: true,
        },
        filters: {
            type: Object,
            required: true,
        },
        employees: {
            type: Array,
            required: true,
        },
        applyFilters: {
            type: Function,
            required: true,
        },
        clearFilters: {
            type: Function,
            required: true,
        },
    },
    methods: {
        async searchByDate() {
            try {
                toast.info("Wait a moment...");
                const data = {
                    start_date: this.filters.initialAccessDate,
                    end_date: this.filters.finalAccessDate,
                };

                const response = await axios_instance.post(
                    "/get-employees-by-date",
                    data
                );
                if (response.status === 200) {
                    if (Array.isArray(response.data.employees)) {
                        toast.success("Employees found successfully");
                        this.$emit("update:employees", response.data.employees);
                    } else {
                        toast.info("No employees found");
                    }
                }
            } catch (error) {
                if (error.response && error.response.status === 404) {
                    toast.error(error.response.data.error, {
                        timeout: 3000,
                        position: "top-right",
                    });
                }
            }
        },
    },
};
</script>
