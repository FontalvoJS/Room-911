<template>
    <div class="filter-section">
        <div class="input-group mb-3">
            <input
                type="text"
                class="form-control"
                placeholder="Search by employee ID"
                aria-label="Search by employee ID"
            />
            <select class="form-select" aria-label="Filter by department">
                <option selected>Filter by department</option>
                <option value="1">Department 1</option>
                <option value="2">Department 2</option>
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
                    value="2016-05-12"
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
                    value="2016-05-12"
                />
            </div>
            <div class="col-md-4 d-flex align-items-end filter-btns">
                <button class="btn btn-primary">Filter</button>
                <button class="btn btn-secondary">Clear filter</button>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-end mb-3">
        <button class="btn btn-new-employee">New employee</button>
    </div>

    <table class="table table-striped table-bordered">
        <thead class="table-dark">
            <tr>
                <th scope="col">Employee ID</th>
                <th scope="col">Firstname ID</th>
                <th scope="col">Lastname</th>
                <th scope="col">Department</th>
                <th scope="col">Total access</th>
                <th scope="col">Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1000001</td>
                <td>John</td>
                <td>Doe</td>
                <td>Department 1</td>
                <td>99</td>
                <td class="action-buttons">
                    <button class="btn btn-sm btn-primary btn-custom">
                        Update
                    </button>
                    <button class="btn btn-sm btn-secondary btn-custom">
                        Disable
                    </button>
                    <button class="btn btn-sm btn-history btn-custom">
                        History
                    </button>
                    <button class="btn btn-sm btn-delete btn-custom">
                        Delete
                    </button>
                </td>
            </tr>
            <tr>
                <td>1000002</td>
                <td>Jin</td>
                <td>Doi</td>
                <td>Department 2</td>
                <td>88</td>
                <td class="action-buttons">
                    <button class="btn btn-sm btn-primary btn-custom">
                        Update
                    </button>
                    <button class="btn btn-sm btn-success btn-custom">
                        Enable
                    </button>
                    <button class="btn btn-sm btn-history btn-custom">
                        History
                    </button>
                    <button class="btn btn-sm btn-delete btn-custom">
                        Delete
                    </button>
                </td>
            </tr>
        </tbody>
    </table>

    <div class="pagination-section">
        <span>Page X of Y</span>
    </div>
</template>

<script>
export default {
    data() {
        return {
            currentTime: "",
        };
    },
    mounted() {
        setInterval(() => {
            this.showTime();
        }, 1000);
    },
    methods: {
        showTime() {
            // Crear una instancia del objeto Date
            const now = new Date();

            // Obtener la hora, minutos y segundos
            let hours = now.getHours();
            let minutes = now.getMinutes();
            let seconds = now.getSeconds();

            // Formato AM/PM (opcional)
            let ampm = hours >= 12 ? "PM" : "AM";
            hours = hours % 12;
            hours = hours ? hours : 12; // Si la hora es 0, se cambia a 12

            // Añadir un 0 al frente de los minutos y segundos si es necesario
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            // Formatear la hora actual
            const currentTime =
                hours + ":" + minutes + ":" + seconds + " " + ampm;

            // Mostrar la hora en el elemento con el id "clock"
            this.currentTime = currentTime;
        },
    },
};
</script>

<style scoped>
/* Encabezado */
body {
    font-family: "Roboto", sans-serif;
}
.table th,
.table td {
    vertical-align: middle;
    text-align: center;
}
.btn-custom {
    padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
    border-radius: 0.2rem;
}
.btn-history {
    background-color: #ffc107;
    color: white;
}
.btn-delete {
    background-color: #dc3545;
    color: white;
}
.input-group-text {
    font-weight: 500;
}
.filter-section {
    margin-bottom: 20px;
}
.filter-btns {
    display: flex;
    gap: 10px;
}
.action-buttons {
    display: flex;
    justify-content: space-around;
}
.btn-new-employee {
    background-color: #0d6efd;
    color: white;
}
.pagination-section {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}
</style>
