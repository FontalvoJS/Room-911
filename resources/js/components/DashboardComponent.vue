<template>
    <div>
        <DashboardModals v-if="pageLoaded" :formAdmin="formAdmin" :formEmployee="formEmployee"
            :updateEmployeeForm="updateEmployeeForm" :departments="departments"
            :submitFormToAddAdmin="submitFormToAddAdmin" :submitFormToAddEmployee="submitFormToAddEmployee"
            :updateEmployee="updateEmployee" :handleFile="handleFile" />
        <!-- Main Container -->
        <div class="container py-5 mt-4 custom_shadow">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3">Administrative Menu</h1>
                <div class="oclock">
                    <span>
                        <strong><i class="fa fa-clock" style="color: #555555c9"></i></strong>
                        <small id="currentTime">{{
                            currentTime || "Initializing time"
                        }}</small>
                    </span>
                </div>
            </div>
            <FilterComponent v-if="pageLoaded" :departments="departments" :filters="filters"
                :applyFilters="applyFilters" :clearFilters="clearFilters" :employees="employees"
                @update:employees="updateObject" />
            <!-- Action Buttons -->
            <small style="float: left; color: gray">Use
                <i class="fa fa-eye" style="color: black !important"></i> to
                simulate ID &nbsp;|&nbsp;<i style="color: black !important" class="fa fa-code"></i>
                <span style="font-weight: 500; color: #ff6723">
                    Andrés Fontalvo</span>
            </small>
            <div class="d-flex justify-content-end mb-3">
                <button type="button" class="btn btn-primary" style="margin-right: 5px" data-bs-toggle="modal"
                    data-bs-target="#employeeRegister">
                    Add employee
                </button>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#adminRegister">
                    Add admin
                </button>
                <button type="button" class="btn btn-primary" style="margin-left: 5px" title="Refresh table"
                    @click="getEmployees(false, true)">
                    <i class="fas fa-sync"></i>
                </button>
            </div>

            <!-- Employees Table -->
            <table class="table table-striped table-bordered" id="employeesTable">
                <thead class="table-dark">
                    <tr>
                        <th scope="col"><i class="fa fa-key"></i></th>
                        <th scope="col"></th>
                        <th scope="col">Firstname</th>
                        <th scope="col">Lastname</th>
                        <th scope="col">Department</th>
                        <th scope="col">Allowed</th>
                        <th scope="col">Denied</th>
                        <th scope="col">Active</th>
                        <th scope="col">Update</th>
                        <th scope="col">Export</th>
                        <th scope="col">Remove</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="employee in paginatedEmployees" :key="employee.id">
                        <td style="
                                color: gray;
                                font-size: 14px;
                                font-family: 'Nunito';
                            ">
                            {{ employee.employee_id }}
                        </td>
                        <td @click="simulateId(employee.employee_id)">
                            <i class="fa fa-eye" title="Simulate ID" :style="{
                                cursor: 'pointer',
                                color: employee.has_access
                                    ? '#ff6723'
                                    : 'initial',
                            }"></i>
                        </td>
                        <td>{{ employee.name }}</td>
                        <td>{{ employee.last_name }}</td>
                        <td>
                            <div class="departments">
                                {{ employee.department }}
                            </div>
                        </td>
                        <td>
                            <small style="text-align: left !important">{{
                                employee.totalAccess || 0
                            }}</small>
                        </td>
                        <td>
                            <small style="text-align: left !important">
                                {{ employee.totalDenied || 0 }}</small>
                        </td>
                        <td>
                            <span class="btn btn-light" title="Black color it means inactive">
                                {{ employee.has_access ? "🟠" : "⚫" }}
                            </span>
                        </td>
                        <td>
                            <button data-bs-toggle="modal" data-bs-target="#employeeEdit" title="Edit employee"
                                @click="setDataUpdate(employee)" class="btn btn-sm btn-custom">
                                <i class="fa fa-edit"></i>
                            </button>
                        </td>
                        <td class="action-buttons">
                            <button title="Export history access to PDF" class="btn btn-sm btn-custom" @click="
                                this.exportHistory(employee.employee_id)
                                ">
                                <i class="fa fa-download"></i>
                            </button>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-dar" title="Delete employee"
                                @click="this.deleteEmployee(employee.id)">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                </tbody>
                <!-- <tbody v-else>
                    <tr
                        v-for="employee in filteredEmployees"
                        :key="employee.id"
                    >
                        <td
                            style="
                                color: gray;
                                font-size: 14px;
                                font-family: 'Nunito';
                            "
                        >
                            {{ employee.employee_id }}
                        </td>
                        <td @click="simulateId(employee.employee_id)">
                            <i
                                class="fa fa-eye"
                                title="Simulate ID"
                                :style="{
                                    cursor: 'pointer',
                                    color: employee.has_access
                                        ? '#ff6723'
                                        : 'initial',
                                }"
                            ></i>
                        </td>
                        <td>{{ employee.name }}</td>
                        <td>{{ employee.last_name }}</td>
                        <td>
                            <div class="departments">
                                {{ employee.department }}
                            </div>
                        </td>
                        <td>
                            <strong>{{ employee.totalAccess || 0 }}</strong>
                        </td>
                        <td>
                            <small style="text-align: left !important">
                                {{ employee.totalDenied || 0 }}</small
                            >
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
                                @click="
                                    this.exportHistory(employee.employee_id)
                                "
                            >
                                <i class="fa fa-download"></i>
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
                </tbody> -->
            </table>
            <div v-if="!pageLoaded" class="mt-4">
                <!-- Spinner -->
                <div class="d-flex justify-content-center">
                    <div class="spinner-border" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </div>
            <!-- Pagination Section -->
            <div class="pagination-section">
                <div class="pagination-container">
                    <button @click="previousPage" :disabled="currentPage === 1" class="pagination-button">
                        <i class="fa fa-angle-left fa-lg"></i>
                    </button>
                    <span class="pagination-text">Página {{ currentPage }} de {{ totalPages }}</span>
                    <button @click="nextPage" :disabled="currentPage === totalPages" class="pagination-button">
                        <i class="fa fa-angle-right fa-lg"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import "../../css/dashboard.css";
import { useThrottle } from "../utils/useThrottle.js";
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
    setDataUpdate,
    simulateId,
    handleFile,
    uploadFile,
    applyFilters,
    clearFilters,
    exportHistory,
    previousPage,
    nextPage,
    updateObject,
} from "../utils/dashboard_methods.js"; // Asegúrate de que las rutas de importación sean correctas
import FilterComponent from "../filter/FilterComponent.vue";

export default {
    data() {
        return {
            // vars
            currentTime: "",
            departments: [],
            employees: [],
            currentPage: 1, // página actual
            elementsPerPage: 10, // elementos por página
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
                file: null,
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
                id: "",
                employee_id: "",
                department: "",
                initialAccessDate: "",
                finalAccessDate: "",
                name: "",
                last_name: "",
            },
            originalEmployeeList: [],
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
    computed: {
        paginatedEmployees() {
            const start = (this.currentPage - 1) * this.elementsPerPage;
            const end = start + this.elementsPerPage;
            return this.employees.slice(start, end);
        },
        totalPages() {
            return Math.ceil(this.employees.length / this.elementsPerPage);
        },
    },
    components: {
        DashboardModals,
        FilterComponent,
    },
    methods: {
        showTime,
        validateFormAdmin,
        validateEmail,
        submitFormToAddAdmin: useThrottle(submitFormToAddAdmin, 2000),
        submitFormToAddEmployee: useThrottle(submitFormToAddEmployee, 2000),
        getDepartments,
        // Aplica throttling a las funciones que dependen de clicks rápidos
        getEmployees: useThrottle(getEmployees, 2000), // 2 segundos de delay entre ejecuciones
        deleteEmployee: useThrottle(deleteEmployee, 2000),
        updateEmployee: useThrottle(updateEmployee, 2000),
        validateFormEmployee,
        setDataUpdate,
        uploadFile: useThrottle(uploadFile, 2000),
        applyFilters: applyFilters,
        clearFilters: useThrottle(clearFilters, 2000),
        handleFile,
        simulateId,
        exportHistory: useThrottle(exportHistory, 2000), // También aquí
        updateObject,
        previousPage,
        nextPage,
    },
};
</script>
