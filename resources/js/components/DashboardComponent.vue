<template>
    <div>
        <DashboardModals
            v-if="pageLoaded"
            :formAdmin="formAdmin"
            :formEmployee="formEmployee"
            :updateEmployeeForm="updateEmployeeForm"
            :departments="departments"
            :submitFormToAddAdmin="submitFormToAddAdmin"
            :submitFormToAddEmployee="submitFormToAddEmployee"
            :updateEmployee="updateEmployee"
        />
        <!-- Main Container -->
        <div class="container py-5 mt-4 custom_shadow">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3">Administrative Menu</h1>
                <div>
                    <span>
                        <strong><i class="fa fa-clock"></i></strong>
                        <small id="currentTime">{{
                            currentTime || "Initializing time"
                        }}</small>
                    </span>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <div class="input-group mb-3">
                    <input
                        type="text"
                        class="form-control"
                        placeholder="Search by employee ID"
                        aria-label="Search by employee ID"
                        v-model="filters.employeeId"
                    />
                    <select class="form-select" v-model="filters.department">
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
                        <label for="initial-access-date" class="form-label"
                            >Initial access date:</label
                        >
                        <input
                            type="date"
                            class="form-control"
                            id="initial-access-date"
                            v-model="filters.initialAccessDate"
                        />
                    </div>
                    <div class="col-md-4">
                        <label for="final-access-date" class="form-label"
                            >Final access date:</label
                        >
                        <input
                            type="date"
                            class="form-control"
                            id="final-access-date"
                            v-model="filters.finalAccessDate"
                        />
                    </div>
                </div>
                <div class="row">
                    <div
                        class="col-md-4 d-flex align-items-end filter-btns mt-2"
                    >
                        <button
                            class="btn btn-secondary"
                            @click.prevent="clearFilters"
                        >
                            Clear filter
                        </button>
                        <button
                            class="btn btn-dark"
                            @click.prevent="applyFilters"
                        >
                            Filter
                        </button>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-flex justify-content-end mb-3">
                <button
                    type="button"
                    class="btn btn-primary"
                    style="margin-right: 5px"
                    data-bs-toggle="modal"
                    data-bs-target="#employeeRegister"
                >
                    Add employee
                </button>
                <button
                    type="button"
                    class="btn btn-primary"
                    data-bs-toggle="modal"
                    data-bs-target="#adminRegister"
                >
                    Add admin
                </button>
            </div>

            <!-- Employees Table -->
            <table
                class="table table-striped table-bordered"
                id="employeesTable"
            >
                <thead class="table-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Key</th>
                        <th scope="col"></th>
                        <th scope="col">Firstname</th>
                        <th scope="col">Lastname</th>
                        <th scope="col">Department</th>
                        <th scope="col">Total access</th>
                        <th scope="col">Active</th>
                        <th scope="col">Update</th>
                        <th scope="col">Export</th>
                        <th scope="col">Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="employee in employees" :key="employee.id">
                        <td>{{ employee.id }}</td>
                        <td>
                            {{ employee.employee_id }}
                        </td>
                        <td>
                            <i
                                class="fa fa-copy"
                                title="Copy ID"
                                :style="{
                                    cursor: 'pointer',
                                    color: employee.has_access
                                        ? '#ff6723'
                                        : 'initial',
                                }"
                                @click="
                                    copyToClipboard(
                                        employee.employee_id,
                                        employee.has_access
                                    )
                                "
                            ></i>
                        </td>
                        <td>{{ employee.name }}</td>
                        <td>{{ employee.last_name }}</td>
                        <td>
                            <span class="departments">{{
                                employee.department
                            }}</span>
                        </td>
                        <td>
                            <strong>{{ employee.totalAccess || 0 }}</strong>
                        </td>
                        <td>
                            <span
                                class="btn btn-light"
                                title="Black color it means inactive"
                            >
                                {{ employee.has_access ? "🟠" : "⚫" }}
                            </span>
                        </td>
                        <td>
                            <button
                                data-bs-toggle="modal"
                                data-bs-target="#employeeEdit"
                                title="Edit employee"
                                @click="setDataUpdate(employee)"
                                class="btn btn-sm btn-custom"
                            >
                                <i class="fa fa-edit"></i>
                            </button>
                        </td>
                        <td class="action-buttons">
                            <button
                                title="Export history access to PDF"
                                class="btn btn-sm btn-custom"
                            >
                                <i class="fa fa-file-pdf"></i>
                            </button>
                        </td>
                        <td>
                            <button
                                class="btn btn-sm btn-dar"
                                title="Delete employee"
                                @click="this.deleteEmployee(employee.id)"
                            >
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Pagination Section -->
            <div class="pagination-section">
                <span>Page {{ currentPage }} of {{ totalPages }}</span>
                <!-- Add pagination controls as needed -->
            </div>
        </div>
    </div>
</template>

<script>
import DashboardModals from "../modals/DashboardModals.vue";
import {
    showTime,
    validateFormAdmin,
    validateEmail,
    submitFormToAddAdmin,
    submitFormToAddEmployee,
    getDepartments,
    getEmployees,
    deleteEmployee,
    updateEmployee,
    validateFormEmployee,
    copyToClipboard,
    setDataUpdate, 
    resetFormUpdate
} from "../utils/methods"; // Asegúrate de que las rutas de importación sean correctas

export default {
    data() {
        return {
            // vars
            currentTime: "",
            departments: [],
            employees: [],
            currentPage: 1,
            totalPages: 1,
            // Forms
            formAdmin: {
                name: "",
                email: "",
                password: "",
                isAdmin: 1,
                isLoading: false,
                errors: {},
            },
            formEmployee: {
                name: "",
                lastname: "",
                department: "",
                isLoading: false,
                errors: {},
            },
            updateEmployeeForm: {
                id: "",
                name: "",
                last_name: "",
                department: "",
                isLoading: false,
                has_access: false,
                errors: {},
            },
            // Filters
            filters: {
                employeeId: "",
                department: "",
                initialAccessDate: "2016-05-12",
                finalAccessDate: "2016-05-12",
            },
            pageLoaded: false,
        };
    },
    mounted() {
        this.showTime();
        setInterval(() => {
            this.showTime();
        }, 1000);
        const load = async () => {
            await this.getDepartments();
            await this.getEmployees();
            this.pageLoaded = true;
        };
        load();
    },
    components: {
        DashboardModals,
    },
    methods: {
        showTime,
        validateFormAdmin,
        validateEmail,
        submitFormToAddAdmin,
        submitFormToAddEmployee,
        getDepartments,
        getEmployees,
        deleteEmployee,
        updateEmployee,
        validateFormEmployee,
        copyToClipboard,
        setDataUpdate,
        resetFormUpdate
    },
};
</script>
